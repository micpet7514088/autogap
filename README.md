# autogap

> **Status:** pre-release scaffold. Public launch planned for May 2026. The real README lands during Phase 1 of the launch plan.

A Claude Code skill that diagnoses the top 3 gaps in any project — code or not — and proposes 3 macro-steps to close them.

## What this is

`autogap` is designed to work on **any project type**: source code, documentation sets, research notes, strategy decks, workflows, creative projects, ops runbooks, or hybrid folders. Most agent skills assume software. This one doesn't.

Given a project directory, `autogap`:

1. Classifies the project type from file signals (not assumptions).
2. Infers the highest-value objective the project is trying to reach.
3. Identifies the 3 biggest gaps blocking that objective.
4. Proposes 3 macro-steps mapped 1:1 to the gaps.
5. Hands control back to the user with a numbered menu. After pick, executes autonomously.

See [`skills/autogap/SKILL.md`](skills/autogap/SKILL.md) for the full skill definition.

## Install

Full installation instructions will land with the Phase 1 README. Until then, copy `skills/autogap/SKILL.md` into your Claude Code skills directory.

## Status

This repository is being prepared for a coordinated public launch. The public announcement, example runs, case studies, and contribution guide are produced during Phase 1 (2026-04-21 → 2026-04-28) of the launch plan tracked separately.

## License

MIT — see [`LICENSE`](LICENSE).

## Authors

Built by the team behind [Synergix](https://www.synergix.it) (fractional IT direction & AI governance) and [Arenia](https://www.arenia.it) (AI coaching avatars for corporate training).
