# Case study 03 — Accessibility audit on two production sites

> **88/100 and 95/100 → 100/100 on both sites, desktop and mobile, in one day.** Real project. Public URLs. Real commit SHAs. Real drift incident + recovery.

- **Date:** 2026-04-20
- **Sites:** [www.synergix.it](https://www.synergix.it), [www.arenia.it](https://www.arenia.it)
- **Status:** shipped, certified live, indexable by search engines.
- **Type:** hybrid — two static marketing sites, different build pipelines, shared hosting.

---

## Context

Two B2B marketing sites for sister companies, hosted on the same Aruba shared account. Both are content-authoritative public-facing web properties:

- **synergix.it** — services site for a fractional IT / AI governance consultancy targeting European finance and insurtech mid-caps.
- **arenia.it** — product site for an AI coaching platform, targeting corporate L&D and training providers.

Both sites rely on inbound organic / SEO / brand trust. The business risk being solved was twofold:

1. **Legal / procurement:** the EU Accessibility Act (EAA) took effect on 28 June 2025. Target clients in finance, insurtech, and regulated training increasingly run vendor due diligence that includes accessibility. An 88/100 Lighthouse score is a yellow flag in procurement screens. Below 90 is worse.
2. **Brand consistency:** arenia.it's value proposition is "accessible training, 24/7, in 175 languages". A marketing site with accessibility gaps is a credibility contradiction caught in 5 minutes by any attentive buyer.

## Objective hypothesis, inferred

> Close the accessibility gap on both production marketing sites to the level where EAA and standard B2B vendor-screen checks pass clean, without breaking existing SEO, content, or hero elements.

Confidence: **High.**

Strongest alternative hypothesis: "Maximum SEO score" (also in play, less urgent; already at 100).

## Diagnosis

**Tools:** Lighthouse navigation mode via Chrome DevTools MCP, on live production URLs. Desktop profile. Supplementary DOM inspection via `evaluate_script`. Reports saved as JSON+HTML.

### Synergix — pre-fix state

| Category | Score | Audits passed | Audits failed |
|---|---|---|---|
| Accessibility | **88/100** | 45 | **4** |
| Best Practices | 100 | — | 0 |
| SEO | 100 | — | 0 |

Failed audits:

1. `color-contrast` — 5 instances. Footer muted text `#6b7280` on dark `#1e293b` (3.02:1). Badge `#059669` on `#e8f8f6` (3.44:1). WCAG AA requires 4.5:1 for small text.
2. `heading-order` — footer column `<h4>` without a preceding `<h3>`.
3. `landmark-one-main` — no `<main>` element. Screen reader users cannot jump to content.
4. `link-in-text-block` — inline citation links to Gartner / McKinsey had 1.3:1 contrast with surrounding text and no non-color distinguisher (WCAG 1.4.1 violation).

### Arenia — pre-fix state

| Category | Score | Audits passed | Audits failed |
|---|---|---|---|
| Accessibility | **95/100** | 51 | **2** |
| Best Practices | 100 | — | 0 |
| SEO | 100 | — | 0 |

Failed audits:

1. `color-contrast` — 3 instances. Identical footer `#6b7280` on `#1e293b` bug as Synergix (shared Tailwind template).
2. `heading-order` — same `<h4>` pattern as Synergix.

Not flagged by Lighthouse but caught by custom DOM inspection: **no `<main>` element on any page**, **no skip link**.

## Top 3 gaps (the autogap output)

The two sites share a templating ancestry. Three gaps surfaced as cross-site:

### Gap 1 — Shared template carries a contrast + heading-order bug across both sites

Single Tailwind footer pattern (`bg-secondary text-gray-500`) used on ~30+ pages total. Fixing the design token once propagates everywhere. Not fixing it means every new page inherits the bug.

### Gap 2 — No `<main>` landmark, no skip link, neither site

Screen reader users have no way to jump past the navigation. Tab-keyboard users traverse the whole navbar on every page load. Additionally, `landmark-one-main` is now a Lighthouse a11y audit baseline — it will be flagged on every future audit.

### Gap 3 — Inline in-text links distinguishable only by color

WCAG 1.4.1 violation. On synergix.it the Gartner and McKinsey citation links had 1.3:1 text-vs-surrounding contrast and used color as the sole distinguisher. The problem is generic: any inline `<a class="text-primary">` in a paragraph on either site has the issue.

## 3 macro-steps (proposed and executed)

### Macro-Step 1 — Centralized template fix in shared partials and CSS

- **Synergix** (source-based build): single edit to `src/partials/footer.html` (`text-gray-500` → `text-gray-400`, `<h4>` column headings → `<h3>`) + edit to `src/partials/header.html` (add skip link). Propagates to all 15 pages at build time.
- **Arenia** (flat HTML): one-shot idempotent Python script `scripts/a11y-fixes.py` that patches all 28 HTML files in place (skip link + `<main id="main">` guarantee + footer contrast + footer h4→h3).
- **CSS (Synergix)**: `.badge-accent` color `#059669` → `#047857` (emerald-700, contrast 3.44 → 4.70). New rule: `p a.text-primary` gets a default underline.

**Complexity:** Medium · **Expected value:** High · **Confidence:** High.

### Macro-Step 2 — Build pipeline extension for `<main>` landmark injection

The Synergix build script already injects header and footer partials via `<!-- INCLUDE: -->` markers. Extending it to auto-wrap the body in `<main id="main">` between the two includes closes the landmark gap for every page — current and future — in one place.

Implemented idempotent: if a page already declares `<main>`, it's left untouched.

**Complexity:** Low · **Expected value:** High · **Confidence:** High.

### Macro-Step 3 — FTP deploy with pre-write backup, live verification, IndexNow ping

Both sites ship over FTP to Aruba. Per-file backup downloaded before overwrite. Post-deploy Lighthouse re-audit as the certification step. IndexNow submit to trigger Bing/Yandex reindex with updated a11y signals.

**Complexity:** Medium · **Expected value:** High · **Confidence:** High.

## Execution

| Step | Outcome |
|---|---|
| Synergix partials + site.css edit | 5 edits on 3 files, `npm run build` → 15 pages rendered |
| Arenia `a11y-fixes.py` run | 28/28 files touched, 85 `<h4>` → `<h3>` rewrites, 28 skip links, 28 `<main id="main">` guarantees |
| Synergix FTP deploy | 54/54 files in 29s, 0 errors (code 226 on every file) |
| Arenia FTP deploy | 29/29 files + 29/29 pre-write backups (backup at `/tmp/web-commander/backup/arenia-20260420-003929/`) |

## The drift incident (and recovery)

Half-way through the deploy, the client reported the hero autoplay video on arenia.it was gone.

**Root cause:** the local git repo was 78 lines behind the live site on `index.html`. A previous out-of-band FTP edit had added the hero `<video>` (plus `<link rel="preload">`, Schema.org `VideoObject`, and autoplay-retry JS) without committing back to git. The a11y deploy overwrote `index.html` with the git version, which did not contain the video.

**Recovery (took ~5 minutes):**

1. The pre-deploy backup (27 files, taken automatically before each overwrite per the deploy skill's rule) preserved the live state.
2. `cp backup/index.html local/index.html` restored the full live version into the git working tree.
3. Re-running the idempotent `a11y-fixes.py` script on the restored file applied the a11y patches to it — without touching the 27 already-patched files (`1/28 files modified`).
4. Re-upload to FTP (single file, code 226). Live-DOM verification via Chrome: `<video>` present, `paused: false`, `currentTime: 10.5s` on 17s clip — autoplay confirmed working.
5. Commit `c8e20f6` on arenia main reconciled git with live. Going forward, git is the source of truth again.

This is the kind of thing a "run and hope" deploy skill misses. The pre-write backup discipline turned a 30-minute recovery into a 5-minute one.

## Verification — post-deploy

Lighthouse re-run on live, both sites, desktop and mobile:

| Site | Device | A11y | Best Practices | SEO | Passed | Failed |
|---|---|---|---|---|---|---|
| synergix.it | desktop | **100** | 100 | 100 | 50 | 0 |
| synergix.it | mobile | **100** | 100 | 100 | 49 | 0 |
| arenia.it | desktop | **100** | 100 | 100 | 52 | 0 |
| arenia.it | mobile | **100** | 100 | 100 | 52 | 0 |

All 4 audits: 100/100/100. No regressions introduced by the fix or by the video restoration.

Supplementary live DOM checks per page: skip-link present, `<main id="main">` resolved, footer headings `<h3>`, footer `text-gray-500` count reduced to 0.

IndexNow submits: **HTTP 202** (synergix) and **HTTP 200** (arenia) — 14 URLs total across both sites queued for reindex by Bing, Yandex, and other IndexNow-participating engines.

## Artifacts

- Lighthouse reports (7 JSON+HTML pairs): pre-fix, post-fix desktop, post-fix mobile, post-restore, IndexNow submissions.
- Synergix main: commit `5b6cec4` (a11y fixes + IndexNow key).
- Arenia main: commit `c8e20f6` (a11y fixes + video reconcile).
- Python script `scripts/a11y-fixes.py` in the arenia site repo — reusable on any Tailwind-based flat HTML site with the same footer pattern. *(Site repo currently private; script available on request.)*
- Build extension `scripts/build.js` in the synergix site repo — auto-injects `<main>` between partials. *(Same privacy note.)*

## What `autogap` did well

- **Classified correctly as hybrid web projects, not as code-only.** The diagnosis frame was "brand / compliance / SEO / conversion" — not "lint your CSS". That framing is what made the EAA angle emerge at all.
- **Ranked gaps by business blocker, not by lint count.** 5 separate instances of color-contrast were folded into one design-token gap. Two separate h4 issues became one template gap.
- **Refused to fake certainty on the Gartner/McKinsey link issue** when the links didn't appear in the local git source. Instead of silently skipping, `autogap` proposed a CSS-level fix that covers any future in-text link — which then also covered the live-only content.

## What we learned

- **Git-live drift is the silent killer for small marketing sites** where FTP edits are easy and commits are optional. The pre-write backup rule in the deploy skill is cheap insurance that paid off.
- **Idempotent scripts over direct edits** when the change touches ≥5 files. The Python script was re-run twice without damage — once originally, once after the restore.
- **"Fix the template, not the instance"** was the right call even though it took longer up front. The next a11y audit on either site will start from 100/100.

## Timing

| Phase | Time |
|---|---|
| Diagnosis (both sites, full Lighthouse + DOM checks) | ~15 min |
| Top-3 gaps + macro-step proposal | ~10 min |
| Macro-step 1 + 2 execution (edits + build + script) | ~45 min |
| Macro-step 3 (deploy + verify + drift recovery + re-verify) | ~40 min |
| Mobile re-audit + IndexNow setup + submit | ~15 min |
| Report + archive | ~15 min |
| **Total** | **~2h20m** |

---

**Takeaway.** `autogap` treats a production website as a *project with an objective*, not as a codebase to lint. The objective here was "be safely buyable by European mid-cap finance clients in 2026". The top-3 gaps and 3 macro-steps were ranked against *that*, not against a generic a11y checklist. The result is a diagnosis that closed cleanly in a day — including an unexpected drift incident — and a public record at 100/100 that the business can point to in the next RFP.
