# Design rationale

Why `autogap` is shaped the way it is. Written for maintainers, contributors, and anyone considering forking.

---

## The one differentiator

**`autogap` does not assume your project is code.**

Almost every Claude Code skill in the wild assumes software: it looks for `package.json`, parses imports, runs linters. When you point it at a folder of research notes, marketing briefs, or a half-finished strategy deck, it either refuses or forces the work into a coding frame.

Most real projects are not pure code. A research project has code and drafts and references. A product launch is decks and spreadsheets and a roadmap and a landing page. A policy rollout is memos and training material and an implementation plan.

`autogap` classifies the project type from file signals — not from the presence of source files — and adapts its "value lens" (user / business / ops / learning / narrative / personal / aesthetic) accordingly. A research repo gets diagnosed on reproducibility. A strategy folder gets diagnosed on internal coherence. A code repo gets the usual treatment.

This is the whole design axis. Everything else serves it.

---

## Why exactly 3 gaps, 3 macro-steps

Not 5. Not 7. Not "as many as the project needs".

**3 is the largest number a user can mentally rank and choose from in under 30 seconds.** 5 forces prioritization but loses the gestalt. 7 produces list-fatigue; the user skims and mis-picks.

**3 is small enough to force the skill to actually rank.** Producing 5 gaps lets the skill dodge the hardest discipline: ranking. With 3 slots, every candidate gap competes against every other, and the skill must justify its top-3 — which is where the value actually is.

**3 macro-steps map 1:1 to the 3 gaps.** No cross-cutting "foundation" steps, no dependencies presented as "first do X before Y". If a macro-step doesn't close a specific gap, it shouldn't exist. If it closes two gaps, it's two macro-steps presented together.

The user can pick 0, 1, 2, or 3. That's an 8-option menu (including "refine diagnosis"). Past 8 the menu becomes the problem.

---

## The menu-stop pattern

After inspection + diagnosis, `autogap` **stops** and presents a menu. It does not start executing. Even in "auto mode" environments, this is load-bearing.

Why:

1. **Correct diagnosis, wrong priority**. The skill's top-3 may be accurate but not what the user wants to fix this week. Forcing it through wastes the user's attention budget.
2. **User consent for side effects**. Macro-step 2 might involve modifying live files, external systems, or irreversible changes. The user has to opt in consciously.
3. **Trust calibration**. Reading the diagnosis before deciding builds the user's trust model of the skill. Auto-executing on the first run breaks that trust — the first time the skill gets it wrong is the last time they use it.

The menu-stop also acts as a **hard commit point** in the skill. Everything before the menu is analysis. Everything after is execution. The skill can be suspended, reviewed, shared as a plan — the menu is the handoff.

---

## Signal-saturation, not artifact-count

Most scan-a-project tools have a fixed budget: "read up to N files". That's brittle — large projects hit the budget before reaching the signal-rich files; small projects waste the budget reading noise.

`autogap` targets **intent-signal saturation** instead: keep inspecting until the last ~5 artifacts did not move the objective hypothesis or change the top-3 gap ranking. Pragmatic stop with a soft cap (~40 artifacts) as a backstop.

Breadth-first first — sample ≥1 artifact per distinct family (code / docs / config / media / prose / config). Then depth on the richest paths. Finally a **disconfirmation pass**: actively look for evidence that the leading hypothesis is wrong, before closing.

The disconfirmation pass is the cheapest high-value step in the whole flow. Skipping it is how diagnostic tools stop noticing the project they're looking at and start pattern-matching to their training set.

---

## "What the project is trying to become"

The classic scan-tool frame: "what's missing from this project?" That question produces infinite valid answers. Every project is missing something.

`autogap`'s frame: "what is this project trying to become, and what's most in the way?"

This reframing does two things:

1. **It bounds the output.** Gaps that don't block the inferred objective don't make the top-3 no matter how valid they are elsewhere. A research project missing CI isn't a gap if the goal is a paper; the same absence on a product launch IS a gap.
2. **It forces the skill to state its interpretation.** The objective hypothesis is an artifact in the output, with confidence + strongest alternative. If the user reads it and says "no, that's not what I'm doing", the menu is where they say "option 8 — refine diagnosis".

The cost: wrong objective = wrong top-3. The user-visible objective statement is what lets them catch this in seconds. Hidden interpretations would be much worse.

---

## What counts as a gap

Strict filter. A gap is something that **blocks the project from reaching the inferred objective**, in any domain:

- Missing capability, artifact, content piece.
- Incoherent core model (domain model, narrative, architecture, argument).
- Weak or absent validation of critical flows / claims / outputs.
- Unclear path from current state to usable / delivered state.
- Missing ops readiness (deploy, publish, hand-off, distribution).
- Missing feedback or observability where material.
- Structural blocker vs. safe forward progress.
- Severely degraded ergonomics for the primary user / author.
- Narrative or positioning gap (for strategy / creative).
- Missing linkage between artifacts that should reinforce each other.

A gap is **NOT**:

- Cosmetic issues.
- Generic best practices with low impact in the specific context.
- Speculative optimizations.
- Low-leverage cleanup that doesn't unblock anything.

Most "best practice" lint output is not a gap.

---

## Autonomy after the pick

On user pick, `autogap` produces a tight ordered implementation plan, then **executes autonomously**. No per-step permission prompts.

Hard stops during execution:

- **Irreversible destructive** action on real data or external systems.
- **Writes to shared or production** systems (with credentials that were not explicitly scoped).
- **Secret handling** — never log, never echo, never commit.
- **Restricted by user global settings** (e.g., `skipDangerousModePermissionPrompt`).

Anything else: proceed. Verify proportional to the risk tier. Close with a compact report and exactly 3 next-steps.

The autonomy is the point. A tool that asks for permission on every step is a tool that wastes the user's attention on the cheap decisions. The whole design puts the user's attention on the menu (high-leverage) and removes it from the rest (low-leverage).

---

## Honesty over confidence

The skill explicitly refuses to:

- Claim completion without verification.
- Fabricate command output, file contents, or outcomes.
- Hide failed verification behind vague language.
- Rank a guess as a root cause.
- Overstate weak evidence.

When sources disagree, say so. When a step is intentionally partial, say so. When a verification was not run, say so. The report format enforces this by having `Evidence` and `Risks / Open points` as required sections.

A report that says "I tried 3 fixes, all failed, here's the blocker" is more useful than one that says "applied fix" without evidence.

---

## Trade-offs we accepted

- **Soft cap of ~40 artifacts.** Skill may miss signal in very large projects. The saturation heuristic plus breadth-first sampling mitigates this, but a 10,000-file monorepo may still get an incomplete picture. We chose this because the alternative (deep dives by default) wastes context on average-case projects.
- **No streaming partial results.** The skill produces the full diagnosis at once. Users waiting on a 30-second scan don't get a progress bar. We decided that streaming would encourage premature intervention; the menu works better as a batch commit.
- **Italian-friendly but not Italian by default.** Output mirrors the user's language; the skill spec is in English. This privileges English contributors in the project's long-term maintenance. Deliberate trade.
- **No built-in history / telemetry.** The skill is stateless across invocations. We considered a `.autogap-history/` file but decided it crosses the "skill that writes to your project silently" line. Users who want tracking can capture the output themselves.

---

## What's out of scope

- Running tests, builds, linters. If the skill thinks the project needs them, it proposes a macro-step; it doesn't silently invoke them.
- Mutating external systems without explicit user context (APIs, deploys, databases).
- Explaining *how* to fix a gap beyond the macro-step level, before the user picks.
- Producing diagrams, visual artifacts, or presentations. Text is the contract.

---

## Further reading

- [`README.md`](../README.md) — user-facing intro.
- [`skills/autogap/SKILL.md`](../skills/autogap/SKILL.md) — the actual skill definition.
- [`docs/case-studies/`](./case-studies/) — real diagnoses.
