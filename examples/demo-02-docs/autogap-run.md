# `/autogap` — expected output

This is the diagnosis `autogap` produces when invoked on `examples/demo-02-docs/`. Reproduce with:

```bash
cd examples/demo-02-docs
claude
> /autogap
```

---

# Project Objective Hypothesis

- **Submit the SR-Shift paper to CIKM 2026 long-paper track by the 2026-05-30 deadline, at quality sufficient to avoid a guaranteed R&R loop.**
- **Project type:** research / analysis
- **Confidence:** High
- **Signals:**
  - `paper.md` front-matter: *"Target venue: CIKM 2026 (long papers)"*.
  - `NOTES.md` dated 2026-04-10: *"Deadline: 2026-05-30. 50 days."*
  - Advisor feedback letter (referenced in `NOTES.md` 2026-03-24) is explicit on what's needed for acceptance.
  - 47-entry `references/sr-shift.bib` — substantial background reading already done.
  - Methods / reproducibility / discussion are the incomplete parts; background and benchmark sections are further along.
- **Alternative hypothesis:** "Any venue will do" — ruled out because of the specific CIKM deadline, field, and word-count constraint. Confidence on primary: High.

# Current State Summary

A mid-draft CIKM long paper with ~50% of the writing done and all the data collected. Three critical sections (methods, reproducibility kit, discussion) are empty or mostly empty. The author has already generated disconfirming evidence (legal split 2) in lab notes that is more valuable than it appears — if integrated into the discussion, it defuses the most likely reviewer attack; if hidden, it becomes the very opening that sinks the paper. Deadline is 50 days.

# Top 3 Gaps

## Gap 1 — Methods section empty; editors reject without reproducible methodology
- **Why matters:** CIKM long-paper criteria require methods sufficient for a reader to reconstruct the benchmark. Section 4 of `paper.md` is a single placeholder line.
- **Evidence:** `paper.md` section 4: `[EMPTY SECTION — placeholder for methodology, targeted 1.5 pages]`. `methods/benchmark_construction.ipynb` has the topical and lexical split code but the temporal split is TODO.
- **Consequence if ignored:** desk-reject probability high; if not desk-rejected, guaranteed R&R adding 3 months.
- **Why top-3:** explicit blocker named by the advisor; single biggest acceptance-risk axis.

## Gap 2 — Reproducibility kit empty, mandatory for this year's CIKM submissions
- **Why matters:** advisor's feedback explicitly notes *"Reproducibility kit is mandatory for CIKM long papers this year. Target journal has a dedicated repo link field at submission."*
- **Evidence:** `reproducibility/` contains only `.gitkeep`. `methods/benchmark_construction.ipynb` has a note that the random seed is set in one notebook but not in `results_v3.ipynb` — reproducibility will fail out of the box on a clean clone.
- **Consequence if ignored:** submission is rejected at the form step if the kit field is mandatory; if soft-required, reviewer score drops by one band.
- **Why top-3:** hard external requirement, small relative effort, high leverage.

## Gap 3 — Discussion fails to surface disconfirming legal-split finding
- **Why matters:** the author's own lab notebook (2026-03-02) records *"legal domain split 2 shows surprising behavior — bm25 beats splade by 7 points nDCG@10"*. This is the strongest reviewer-attack target if unaddressed, and the strongest reviewer-bypass if addressed transparently.
- **Evidence:** `paper.md` section 6 Discussion: `[TODO — at minimum: limitations, alternative interpretations, disconfirming evidence from split 2 of legal domain.]` — author has flagged it for self.
- **Consequence if ignored:** reviewer 2 opens with it; paper is fatally wounded in first-round review.
- **Why top-3:** the difference between "integrated disconfirmation" and "missing disconfirmation" is often the difference between accept and reject at this tier of venue.

# 3 Macro-Steps

## Macro-Step 1 — Complete methods section (1.5 pages) from existing lab notes + notebooks
- **Goal:** a methods section that lets a motivated reader reconstruct SR-Shift.
- **What changes:** section 4 of `paper.md` fully written; `methods/benchmark_construction.ipynb` completed with the temporal split (stubbed news parser finished); one pass of methodology citations from the existing `.bib`.
- **Complexity:** Medium · **Expected value:** High · **Confidence:** High

## Macro-Step 2 — Produce the reproducibility kit
- **Goal:** `reproducibility/` contains seeds, split exports, a `run.sh` that reproduces Table 1 of results on a clean clone in <30 min.
- **What changes:** set seeds consistently (fix the notebook discrepancy); export the 3 splits as committed files; write `run.sh`; document environment with `requirements.txt` or `environment.yml`; README at repro root.
- **Complexity:** Medium · **Expected value:** High · **Confidence:** Medium (depends on environment portability of the splade codepath).

## Macro-Step 3 — Integrate the legal-split disconfirmation into discussion
- **Goal:** section 6 of `paper.md` has a 2-paragraph *Alternative interpretations and limitations* subsection anchored by the legal split 2 finding, honestly reported.
- **What changes:** rewrite section 6; adjust abstract headline number if needed; add 1-2 citations if the alternative interpretation has a literature hook.
- **Complexity:** Low · **Expected value:** High · **Confidence:** High

# Recommendation

**Order:** 1 and 2 in parallel → 3 last.

The methods section (1) and reproducibility kit (2) have independent critical paths — different skills, different time budgets, independent deliverables. They should run in parallel; at 50 days to deadline this is how you leave slack. Discussion (3) has the lowest complexity but touches content affected by finalized methods numbers, so do it last (week 6 of 8). Leave 1 week of slack before submission for final reads and advisor turnarounds.

# User Choice

Choose what to implement:

1. Macro-Step 1 only
2. Macro-Step 2 only
3. Macro-Step 3 only
4. Macro-Steps 1 + 2 — full methodology + repro kit, no discussion yet
5. Macro-Steps 1 + 3 — methodology + discussion, no repro kit (risky)
6. Macro-Steps 2 + 3 — repro + discussion, methodology still empty (deal-breaker)
7. All three
8. None now; refine diagnosis

*Typical pick:* **7** (the deadline is the forcing function).
