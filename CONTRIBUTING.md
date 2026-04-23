# Contributing to autogap

Thanks for considering a contribution. This project stays small and focused. We prefer **real use cases over theoretical improvements**.

---

## What we welcome

- **Bug reports** with a concrete reproduction — `autogap` misclassified a project type, inferred the wrong objective, proposed a macro-step that didn't close the gap.
- **Case studies** — diagnoses you ran on real projects, anonymized if needed, with the output and what happened next. These are the strongest contributions.
- **Doc fixes** — clarifications, language polish, broken links, outdated examples.
- **SKILL.md improvements** — tighter prompts, fewer tokens, better disconfirmation passes.

## What we won't accept

- **Skills that require a paid SaaS** to function, or that route requests through a server we don't control. (Standard awesome-list policy. The skill must stay local-only.)
- **Scope expansion "just in case"** — speculative features with no concrete gap behind them.
- **Refactors for their own sake** — cleanup PRs that don't close a real issue.
- **Changes that break the menu-stop pattern** — autogap must never auto-execute before the user picks.

---

## Local development

```bash
git clone https://github.com/micpet7514088/autogap.git
cd autogap
bash install.sh          # macOS / Linux
# .\install.ps1          # Windows PowerShell 7+

# Restart Claude Code, cd into any real project, invoke /autogap.
```

---

## Testing a change

Before you open a PR, run the skill on **at least three project types**:

1. A source code repo (any language).
2. A folder of documents (markdown, PDF, notes, no code).
3. A strategy or workflow folder (plans, OKRs, briefs, spreadsheets).

For each run, check:

- Objective hypothesis is plausible and specific to the project (not generic).
- 3 gaps are actionable blockers, not cosmetic polish.
- 3 macro-steps map 1:1 to the 3 gaps.
- Menu stop happens — the skill does **not** start executing before the user picks.

If any of those fail, the change is not ready. If all pass, attach one of the diagnosis outputs to your PR description.

---

## Style guide for SKILL.md

- **Terse.** Every line costs context on every invocation. If a sentence doesn't change behavior, remove it.
- **Verbs over adjectives** in gap descriptions. "Missing methodology section" > "Inadequate methodology documentation".
- **No emoji** in the skill itself. Output formatting is up to the user's Claude Code config.
- **No marketing** in the skill. No "industry-leading", no "robust", no "seamless".
- **Concrete examples** > abstract principles.

---

## PR process

1. **Open an issue first** if the change is non-trivial. Align on scope before code.
2. **One logical change per PR.**
3. **Reference the gap** your change closes in the description: *"Before: `autogap` misclassified research folders as `creative` when they contained LaTeX. After: checks for `.tex` files before classifying."*
4. **Include a diagnosis output** from the 3-project test above, at least for the most relevant project type.
5. **Keep commits atomic.** Rebase before merge.

Human review is where the time goes. CI is intentionally light.

---

## Community norms

- Be direct. Skip the preamble.
- Disagree with the code, not the person.
- If a reviewer says "I'm not sure", they mean "please clarify", not "I reject this".
- If you disagree with a reviewer, argue with evidence (a run, a repro, a counter-example), not with opinion.

---

## Authors and maintainers

Maintained by [Synergix](https://www.synergix.it) and [Arenia](https://www.arenia.it). See [`README.md`](./README.md#authors) for context.

Issues: <https://github.com/micpet7514088/autogap/issues>
