# autogap

> **The first Claude Code skill that diagnoses the top 3 gaps in any project — code or not.**

Give `autogap` a project directory. It classifies the project type from file signals (not assumptions), infers the top-value objective the project is reaching for, and reports the 3 biggest gaps blocking that objective plus 3 macro-steps to close them. Then it hands you a numbered menu and waits. If you pick, it plans and executes autonomously.

It works on:

- **source code** — single package or monorepo
- **documentation sets** — research notes, spec folders, knowledge bases
- **strategy / business** — roadmaps, OKRs, decks, briefs
- **creative / content** — drafts, outlines, edit lists
- **ops / infra** — runbooks, playbooks, inventories
- **hybrid** — whatever you've actually got

Most agent skills assume software. `autogap` doesn't.

---

## 30-second example

```
$ cd research-project/
$ claude
> /autogap

# Project Objective Hypothesis
- Publish a peer-reviewed paper on X by Q3 2026
- Project type: research
- Confidence: High
- Signals: 3 draft sections, referee feedback letter, 47-entry BibTeX,
  methods/ folder with 2 Jupyter notebooks, reproducibility/ empty

# Top 3 Gaps
## Gap 1 — Methods section incomplete
  Why it matters: editors reject without reproducible methodology.
  Evidence: methods.md is 40% length of Background + has 3 TODO markers.
  Consequence: guaranteed R&R loop, likely 3-month delay.

## Gap 2 — No reproducibility kit
  Why it matters: target journal requires data + code on acceptance.
  Evidence: reproducibility/ directory empty; notebooks have no seeds.
  Consequence: acceptance delayed until kit is produced.

## Gap 3 — Discussion skirts disconfirmation
  Why it matters: weakest reviewer target; editor likely flags.
  Evidence: 0 mentions of limitations; no alternative-explanation section.
  Consequence: weakest part of the paper, most reviewer ammunition.

# 3 Macro-Steps
## Macro-Step 1 — Complete methods from lab notes (Low / High / High)
## Macro-Step 2 — Produce reproducibility kit  (Medium / High / Medium)
## Macro-Step 3 — Add disconfirmation to discussion (Low / Medium / High)

Choose what to implement:
1. Macro-Step 1 only
2. Macro-Step 2 only
3. Macro-Step 3 only
4. Macro-Steps 1 + 2
...
```

Pick a number. `autogap` plans, executes, verifies, and reports exactly what changed.

No user confirmation on every step. No fake completion. Stops cleanly on ambiguous irreversible moves.

---

## Why it's different

| Most skills | `autogap` |
|---|---|
| Assume your project is code | Classifies project type from signals |
| Suggest a long list of improvements | Ranks exactly 3 gaps, by blocker strength |
| Lecture best practices | Infers what the project is trying to *become* |
| Ask you 20 questions upfront | Deep-inspects first, asks ≤2 questions only if blocked |
| Execute everything or nothing | User picks a subset via menu, then autonomous exec |
| Silent on uncertainty | Confidence + strongest alt hypothesis, explicit |

Full thinking in [`docs/design-rationale.md`](./docs/design-rationale.md).

---

## Install

**Method 1 — User-level skill (recommended):**

```bash
git clone https://github.com/micpet7514088/autogap.git ~/autogap
mkdir -p ~/.claude/skills/autogap
ln -s ~/autogap/skills/autogap/SKILL.md ~/.claude/skills/autogap/SKILL.md
```

Restart Claude Code. From any project directory: `claude` → `/autogap`.

**Method 2 — Project-level skill:**

```bash
mkdir -p .claude/skills/autogap
curl -sSL https://raw.githubusercontent.com/micpet7514088/autogap/main/skills/autogap/SKILL.md \
  -o .claude/skills/autogap/SKILL.md
```

**Method 3 — Manual:**

Copy [`skills/autogap/SKILL.md`](./skills/autogap/SKILL.md) into any dir Claude Code scans for skills.

---

## Examples you can run

Three demo projects, one per major project type. Each one has an expected-output file so you can compare what `autogap` produces against what it should produce.

- [`examples/demo-01-code/`](./examples/demo-01-code/) — Python CLI blocked on PyPI release → [expected output](./examples/demo-01-code/autogap-run.md)
- [`examples/demo-02-docs/`](./examples/demo-02-docs/) — CIKM 2026 paper, 50 days to deadline → [expected output](./examples/demo-02-docs/autogap-run.md)
- [`examples/demo-03-strategy/`](./examples/demo-03-strategy/) — Q3 product launch with top-3 LOI contingency → [expected output](./examples/demo-03-strategy/autogap-run.md)

See [`examples/`](./examples/) for the full set and the run instructions.

## Case studies

Real diagnoses on real projects. Some are anonymized; one is a fully public post-mortem.

- **[Accessibility audit on two production sites — 88/95 → 100/100 in one day](./docs/case-studies/03-a11y-two-sites.md)**
  Diagnosis, fix, deploy, certification. Includes a real drift incident + recovery. Fully public, real commit SHAs.
- **[AI Act readiness — European insurtech mid-cap](./docs/case-studies/01-synergix-ai-governance.md)** — anonymized, draft
- **[L&D program ROI — B2B training provider](./docs/case-studies/02-arenia-ld-program.md)** — anonymized, draft

See [`docs/case-studies/`](./docs/case-studies/) for the full set.

---

## How it works, briefly

1. **Classify** project type from file signals (folder tree, file types, naming, metadata). No software default.
2. **Infer** the top-value objective the project is trying to reach. State confidence, name the strongest alternative hypothesis.
3. **Scan** breadth-first. Deepen on the richest paths. Sample ≥1 artifact per distinct family (code / docs / config / media). Run a disconfirmation pass before closing.
4. **Rank** gaps by blocker strength, not cosmetic polish. "Nice-to-have" is not a gap.
5. **Present** a 3-gap / 3-macro-step menu. Stop. No auto-execute.
6. **On pick:** plan tight, execute autonomously, verify proportional, report compactly with 3 next-steps.

Architecture choices, trade-offs, and the "why 3 (not 5, not 7)" question: [`docs/design-rationale.md`](./docs/design-rationale.md).

---

## Contributing

See [`CONTRIBUTING.md`](./CONTRIBUTING.md). Short version:

- Real use cases welcome, theoretical improvements discouraged.
- One change per PR, closing one concrete gap.
- No SaaS wrappers. No scope creep "just in case".

Issues and PRs: <https://github.com/micpet7514088/autogap>.

---

## License

[MIT](./LICENSE) — use freely, attribution appreciated.

---

## Authors

Built by the team behind:

- **[Synergix](https://www.synergix.it)** — fractional IT direction and AI governance for European finance and insurtech mid-caps. 20+ years of enterprise delivery applied to AI programs.
- **[Arenia](https://www.arenia.it)** — AI coaching avatars for corporate training. Realistic, scalable practice with measurable KPI frameworks.

`autogap` was battle-tested on our own client work before we open-sourced it.
