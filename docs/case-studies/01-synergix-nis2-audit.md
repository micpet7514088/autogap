# Case study 01 — NIS2 incident response audit on a European insurer

> **Real anonymized Synergix engagement.** Sector, team composition, and outcomes preserved; client identity and identifying details redacted.

- **Date:** 2026 Q1
- **Sector:** insurance (European mid-cap)
- **Project type:** strategy + compliance + operations hybrid
- **Trigger:** external audit request on the NIS2 response plan
- **Engagement shape:** 3 parallel workstreams · team = Synergix principal + client CISO + client Legal · intensive cadence
- **Outcome:** removal of blockers to correct incident handling; procedural improvement measurable at staff-operations level.

---

## Context

A European mid-cap insurance company had built its NIS2 response plan in-house over 2025, with input from multiple internal teams and one external compliance firm. Before committing to publication and rollout across subsidiaries, the board requested an **independent external audit** to verify that the plan actually works under the regulatory obligations NIS2 imposes on essential entities.

The stakes were concrete: under NIS2 the responsible management body can be held personally accountable for failures to implement adequate cybersecurity risk-management measures. "We have a plan" is not a defence. "The plan was audited and we closed the gaps" is.

Synergix was engaged as the independent auditor. No rewriting, no consulting on content — just diagnosis and fix path, with the client's own CISO and Legal owning the implementation.

## The artifact bundle `autogap` ran on

- The current NIS2 response plan (main document, 40+ pages).
- The Disaster Recovery procedures referenced from it (2 documents, 60+ pages total).
- The incident classification matrix and escalation ladder.
- The external-reference list (URLs, standards, internal policies) that the plan cites to establish authority.
- The internal training material derived from the plan (slide deck + quick-reference card).
- Board-level presentations of the plan from the last 6 months.

## Objective hypothesis, inferred

> Pass the independent audit on NIS2 readiness cleanly, with a short list of actionable fixes that can be closed before the next regulatory inspection window, without a full-scale rewrite of the existing response plan.

**Confidence:** High.

Signals: board commissioned the audit (not a rewrite); existing plan is production-printed already; internal training has begun; external-reference list is present, implying intent to stand behind citations.

**Strongest alternative:** "Benchmark against European peers" — also present but secondary. The audit mandate was explicit.

## Current state summary

The response plan is the output of honest internal work. Most of the substance is defensible. The failure modes concentrate in three places where the plan touches external reality: regulation compliance at the edges, Disaster Recovery procedure under adversarial conditions, and reference integrity. None of these is a full rewrite; all three are fixable in a compressed audit window.

## Top 3 gaps

### Gap 1 — Non-trivial deviation from NIS2 on notification + documentation requirements

Parts of the plan predate the final NIS2 transposition. Two notification-timing windows and one documentation retention requirement are off-spec. Not a catastrophic gap — but enough to fail an inspection, and enough for a regulator to argue that the plan was never genuinely re-validated after the final text.

**Why top-3:** the audit's primary question is "does this comply?" and the honest answer on 3 points is "not yet". That single fact neutralises everything else if unaddressed.

### Gap 2 — Error in the Disaster Recovery procedure

One of the DR procedures contains an error in the failover sequence. Under an adversarial scenario — attacker persists in the primary, DR triggered, attacker moves laterally along the documented failover path — the procedure as written amplifies rather than contains. The gap is not theoretical; it was reproducible from the document itself by walking it through cold.

**Why top-3:** DR is the fallback. A flawed fallback is worse than no fallback — it creates false confidence in the tabletop and real damage in the incident.

### Gap 3 — Broken external references: procedural and URL rot

The plan cites ~30 external references to establish authority (NIST, ENISA guidance, specific ISO clauses, EU regulation articles, internal policies by ID). A sample check finds broken URLs (moved, restructured, or replaced) and internal policy IDs that refer to superseded versions. This is the cheapest gap to fix and the most embarrassing to have found by an external auditor first. It also signals, at scale, that the plan has not been maintained since publication.

**Why top-3:** reference rot is a leading indicator of document abandonment. An auditor who finds it on the first page treats every other claim in the document as potentially stale.

## 3 macro-steps

### Macro-Step 1 — NIS2 compliance delta + targeted rewrite

- **Goal:** close the 3 specific deviation points (notification windows, retention) with minimal rewrite — surgical edits, not a new plan.
- **What changes:** side-by-side comparison against the current NIS2 text, targeted paragraph edits, sign-off trail recorded in the document revision history.
- **Complexity:** Medium · **Value:** High · **Confidence:** High

### Macro-Step 2 — DR procedure correction with adversarial walkthrough

- **Goal:** rewrite the failover sequence to contain rather than amplify; validate the corrected sequence against 3 adversarial scenarios in a tabletop.
- **What changes:** the failover section of the DR procedure, the related runbooks, and the tabletop log entry.
- **Complexity:** Medium · **Value:** Very High (this is the real risk-reducer) · **Confidence:** High

### Macro-Step 3 — Reference integrity sweep

- **Goal:** every external reference either (a) resolves to the currently authoritative source or (b) is removed.
- **What changes:** the reference list, inline citations, internal policy ID versioning.
- **Complexity:** Low · **Value:** Medium · **Confidence:** High

## Recommended execution order

**1, 2, 3 in parallel workstreams, with 2 owning the longest critical path.**

Workstream 1 (compliance delta) owned by client Legal with Synergix principal. Workstream 2 (DR correction) owned by client CISO with Synergix principal on tabletop facilitation. Workstream 3 (reference sweep) owned by junior compliance staff with Synergix review at the end. All three run concurrently; the tabletop in workstream 2 is the integration point.

## What happened

Engagement ran intensive over 3 weeks. Three workstreams in parallel, one joint tabletop mid-engagement to validate Macro-Step 2.

- **Macro-Step 1:** targeted paragraph edits across 2 documents; sign-off by client CISO and Legal Director.
- **Macro-Step 2:** failover sequence rewritten; adversarial tabletop walked through 3 scenarios (ransomware in primary + DR triggered; lateral from DR back to primary; region-wide outage + partial DR). Original sequence would have amplified in 2 of 3; corrected sequence contained in all 3.
- **Macro-Step 3:** references checked end-to-end; broken URLs fixed, internal policy IDs re-versioned, obsolete citations removed.

End of engagement: the plan was re-approved for publication with the revised version; staff training slide deck updated to match; a short "what changed and why" memo attached to the plan for inspector readability.

## Outcomes

- **Removal of blockers to correct incident handling.** The DR failover correction eliminates a scenario in which the procedure itself would have accelerated damage under attack.
- **Procedural improvement at staff level.** Staff training now matches the corrected plan; the quick-reference card was simplified alongside.
- **Audit-ready posture.** The client can now answer an external regulator inquiry by pointing at the dated audit record, the 3 closed gaps, and the revised plan — a substantive answer, not a posture.
- **Numerical metrics:** not disclosed (client preference).

## What `autogap` did well

- **Refused to produce a long list.** The temptation on a 40-page plan is to surface 15 minor findings. `autogap` held the 3-gap discipline: these 3 are the blockers; the rest is noise for a follow-up maintenance cycle.
- **Ranked by blocker strength, not by visibility.** The broken URLs (Gap 3) were the first thing anyone would notice and were ranked last — correctly. The DR error (Gap 2) was the one that actually matters under attack and was ranked second (behind the legally binding compliance delta) — correctly.
- **Framed around the audit's objective.** "Does this plan survive an external audit?" gave a sharper diagnosis than "what could be improved about this plan?" would have.

## What we learned

- **Reference rot is a leading indicator.** When an auditor finds 5+ broken URLs on page 1, they treat the rest of the document with suspicion — even if the substance is correct. A low-cost sweep buys disproportionate credibility.
- **Adversarial walkthroughs find what document reviews miss.** The DR failover error was not visible in read-through; it emerged only when walked cold as an attacker. Tabletops before publication are worth the time.
- **An external audit with closed gaps is a stronger defence than an internal plan with no findings.** Boards and regulators both value the diagnosis-and-close cycle over the "our plan had no problems" claim.

---

*Published with client approval. Sector and team composition preserved; identifying details redacted per Synergix engagement policy.*
