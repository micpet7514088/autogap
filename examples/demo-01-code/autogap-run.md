# `/autogap` — expected output

This is the diagnosis `autogap` produces when invoked on `examples/demo-01-code/`. Reproduce with:

```bash
cd examples/demo-01-code
claude
> /autogap
```

---

# Project Objective Hypothesis

- **Ship `expensetrack` v0.2 to PyPI.**
- **Project type:** code / software · Python CLI / library hybrid
- **Confidence:** High
- **Signals:**
  - `README.md` lists "Publish to PyPI ← blocking" as the next milestone.
  - `TODO.md` has a dedicated "v0.2 — blocking PyPI release" section.
  - `pyproject.toml` exists but with 4 placeholder `TODO` lines in metadata.
  - `src/expense_tracker.py` is functional at v0.1 (CSV parse + monthly aggregation work).
  - One `FIXME` in date parsing — known bug, not fatal.
  - No `LICENSE`, no `.github/workflows/`, no tests committed (only `tests/.gitkeep`).
- **Alternative hypothesis:** "Internal-only tool" — ruled out because the project explicitly targets PyPI + Homebrew (public distribution). Confidence on primary: High.

# Current State Summary

v0.1 code is working. Metadata, license, tests, and CI are missing. Distribution infrastructure is the blocker; no code quality blocker beyond the known FIXME. The project is closer to a release than the PyPI metadata suggests.

# Top 3 Gaps

## Gap 1 — No LICENSE blocks PyPI publish
- **Why matters:** PyPI strongly encourages a license classifier; packages without a license are legally ambiguous for downstream users. Homebrew formula will be rejected outright.
- **Evidence:** `ls LICENSE*` returns nothing. `pyproject.toml` has `# TODO: authors, license, classifiers, urls`.
- **Consequence if ignored:** publish attempt fails metadata validation, or publishes a legally unusable package.
- **Why top-3, not minor:** this is a hard blocker on the stated objective, not a polish item.

## Gap 2 — Zero tests + a known FIXME → cannot publish with confidence
- **Why matters:** publishing with a known date-parsing bug that breaks European users would require an immediate v0.2.1 hotfix and damage first impressions.
- **Evidence:** `tests/` contains only `.gitkeep`. `src/expense_tracker.py:line-15` `FIXME: date parsing is naive — breaks on European dd/mm/yyyy`.
- **Consequence if ignored:** first non-US user who installs hits the bug; no regression harness to catch it next time.
- **Why top-3:** directly tied to release-quality, not speculative coverage improvement.

## Gap 3 — No CI means post-release regressions ship invisibly
- **Why matters:** once `expensetrack` is on PyPI, any future commit that breaks CSV parse or date parsing ships to users unless a pre-merge gate catches it.
- **Evidence:** no `.github/workflows/`, no `.circleci/`, no `tox.ini`.
- **Consequence if ignored:** silent regressions post-v0.2; credibility damage on a public package.
- **Why top-3:** once tests exist (Gap 2), CI is the cheap multiplier — without it, the tests don't protect users.

# 3 Macro-Steps

## Macro-Step 1 — Add LICENSE + finalize pyproject.toml metadata
- **Goal:** pass `twine check dist/*` with zero warnings on v0.2 artifact.
- **What changes:** add `LICENSE` (MIT — default for Python OSS, no contributor agreement overhead). Fill `pyproject.toml` with `authors`, `license = { text = "MIT" }`, `classifiers` (OSI, Python versions), `urls.Homepage`, `urls.Repository`.
- **Why it increases value:** unblocks publish. One-shot, durable.
- **Complexity:** Low · **Expected value:** High · **Confidence:** High

## Macro-Step 2 — Write 3-5 tests covering CSV parse + date parsing + empty input
- **Goal:** lock in v0.1 behavior and the date-parse fix before release.
- **What changes:** `tests/test_parse.py` with: happy-path CSV, US date format, European dd/mm/yyyy (this change fixes the FIXME), empty CSV, malformed row. Refactor `aggregate_monthly` to accept a date format param or auto-detect.
- **Why it increases value:** closes the FIXME, builds the regression harness for Macro-Step 3.
- **Complexity:** Medium · **Expected value:** High · **Confidence:** High

## Macro-Step 3 — GitHub Actions CI running tests on Python 3.10 / 3.11 / 3.12
- **Goal:** every push and every PR runs `pytest` on the 3 supported versions.
- **What changes:** `.github/workflows/test.yml` with matrix build. Add `pytest` to `pyproject.toml` dev deps.
- **Why it increases value:** once tests exist, CI is the permanent backstop.
- **Complexity:** Low · **Expected value:** Medium-High · **Confidence:** High

# Recommendation

**Order:** 1 → 2 → 3.

Macro-Step 1 is the shortest wall-clock (≤30 min) and unblocks publish metadata independent of code. Macro-Step 2 builds on v0.1 code without changing behavior. Macro-Step 3 has zero value without Macro-Step 2 (CI with empty test dir passes trivially). All three can realistically ship in a single focused afternoon.

# User Choice

Choose what to implement:

1. Macro-Step 1 only — minimum for PyPI publish (but bug still ships)
2. Macro-Step 2 only — fixes the bug, delays publish
3. Macro-Step 3 only — low value without 2
4. Macro-Steps 1 + 2 — publish-ready with bug fixed
5. Macro-Steps 1 + 3 — publish with CI on the existing empty test dir (symbolic)
6. Macro-Steps 2 + 3 — fix quality, no publish
7. All three
8. None now; refine diagnosis

*Typical pick:* **4 or 7**.
