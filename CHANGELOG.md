# Changelog

All notable changes to `autogap` are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning follows [SemVer](https://semver.org/).

## [Unreleased]

Nothing pending yet.

## [0.1.0] — 2026-05-13

First public release.

### Added

**Core skill**
- `skills/autogap/SKILL.md` — the autogap skill spec: project-type classification from file signals, semantic objective inference, 3-gap / 3-macro-step diagnosis format, menu-stop pattern, autonomous exec on pick.
- `docs/design-rationale.md` — explicit design principles and trade-offs (why 3 gaps, signal saturation over artifact count, menu-stop consent model, no-telemetry stance).

**Examples**
- `examples/demo-01-code/` — Python CLI blocked on PyPI release. Covers code / software project type.
- `examples/demo-02-docs/` — CIKM 2026 paper, 50 days to submission deadline. Covers research / analysis project type.
- `examples/demo-03-strategy/` — Q3 product launch with top-3 LOI account contingency. Covers strategy / business project type.
- Each demo includes an `autogap-run.md` with the expected diagnosis output.

**Case studies**
- `docs/case-studies/03-a11y-two-sites.md` — accessibility audit on two production sites (88/95 → 100/100 in one day). Fully public, real commit SHAs, includes a drift incident and recovery.
- `docs/case-studies/01-synergix-nis2-audit.md` — NIS2 incident response audit on a European insurer. Anonymized.
- `docs/case-studies/02-arenia-ai-coach-finetuning.md` — AI Coach fine-tuning for a healthcare vertical, retention +17%. Anonymized.

**Install**
- `install.sh` — one-liner install for macOS and Linux. Symlinks from the cloned repo; downloads directly when piped via `curl | bash`. Supports `--update`.
- `install.ps1` — one-liner install for Windows PowerShell 7+. Attempts symlink; falls back to copy with advisory if Developer Mode is off. Supports `-Update`.

**Tests**
- `tests/validate_output.py` — structural validator for all `autogap-run.md` demo outputs. Checks required sections, gap count, macro-step count, and menu completeness.
- `.github/workflows/ci.yml` — CI workflow that runs `validate_output.py` on every push and pull request.

**Project**
- `README.md`, `CONTRIBUTING.md`, `LICENSE` (MIT), `CHANGELOG.md`, `.gitignore`.
- `.github/ISSUE_TEMPLATE/` — bug report and feature request templates.
- `.github/PULL_REQUEST_TEMPLATE.md`.

### Design decisions

- No telemetry. No writes to the user's project without an explicit pick.
- No SaaS dependency. The skill runs entirely within the user's Claude Code session.
- Menu-stop is a hard invariant. Auto-exec before pick is a regression, not a feature.
- Output language mirrors the user's language. No English-only bias.
