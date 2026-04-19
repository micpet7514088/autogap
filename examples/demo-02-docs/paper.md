# Sparse Retrieval Under Distribution Shift: A Benchmark Study

**Authors:** [REDACTED]
**Target venue:** CIKM 2026 (long papers)
**Word count (target):** 8,000 · **current:** 4,200

## Abstract

We study how classical sparse retrieval methods (BM25, SPLADE-family)
behave when the query distribution shifts from the one used for tuning.
We introduce SR-Shift, a benchmark covering 4 domains and 3 shift types,
and compare 5 retrievers. We find [TODO: finalize headline number].

## 1. Introduction

Retrieval-augmented generation has brought sparse retrievers back into
focus. Yet most benchmarks evaluate on in-distribution queries. Real
deployments face distribution shift. [3 paragraphs written, last one
ends with TODO.]

## 2. Background

Covered: BM25 family, SPLADE-v2, distribution shift taxonomy. 2 pages.

## 3. SR-Shift Benchmark

- 4 domains: legal, biomedical, product reviews, news.
- 3 shift types: topical, lexical, temporal.
- See `methods/benchmark_construction.ipynb` [INCOMPLETE — missing
  temporal split code].

## 4. Methods

[EMPTY SECTION — placeholder for methodology, targeted 1.5 pages]

## 5. Results

See `methods/results_v3.ipynb` [partial: bm25 and splade-v2 done,
splade-v3 and two baselines pending].

## 6. Discussion

[TODO — at minimum: limitations, alternative interpretations,
disconfirming evidence from split 2 of legal domain.]

## 7. Conclusion

[TODO]

## Acknowledgements

[TBD]

## References

See `references/sr-shift.bib` (47 entries).
