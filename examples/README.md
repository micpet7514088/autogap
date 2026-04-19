# Examples

Three small but signal-rich project directories you can run `autogap` on. Each is designed around a different project type, to demonstrate that "any project" is not marketing copy. Each demo has an `autogap-run.md` showing the expected diagnosis — read that first to see what `autogap` surfaces, then run it yourself and compare.

| Demo | Project type | Realistic scenario | Expected output |
|---|---|---|---|
| [`demo-01-code/`](./demo-01-code/) | code / software | Python CLI, v0.1 working, v0.2 blocked on PyPI publish prerequisites | [autogap-run.md](./demo-01-code/autogap-run.md) |
| [`demo-02-docs/`](./demo-02-docs/) | research / analysis | CIKM 2026 long-paper submission, 50 days to deadline, methods + reproducibility + discussion unfinished | [autogap-run.md](./demo-02-docs/autogap-run.md) |
| [`demo-03-strategy/`](./demo-03-strategy/) | strategy / business | Q3 2026 product launch with top-3 LOI contingency; marketing lead unstaffed, reference customers short | [autogap-run.md](./demo-03-strategy/autogap-run.md) |

## Run one yourself

```bash
cd examples/demo-01-code        # or demo-02-docs / demo-03-strategy
claude
> /autogap
```

Compare the live output with `autogap-run.md` in the same directory. Two things to look for:

1. **Same top-3 gaps** (the order may vary; the identity should converge).
2. **Same objective hypothesis.** If `autogap` picks a different objective, the rest of the diagnosis will drift — that's a sign you should inspect its "Signals" section for whether it missed a key artifact.

## Why these three

- **Code** is the expected case. It should work trivially.
- **Research docs** is the textbook non-code case. If this doesn't work, the "any project" claim is false.
- **Strategy / workflow** is the hardest case — the signals are implicit, scattered across prose and structured docs. If this works, the skill has real inferential power beyond file-type pattern matching.

## Contributing an example

See [`../CONTRIBUTING.md`](../CONTRIBUTING.md). Example projects that illustrate a *failure mode* are as valuable as success cases.
