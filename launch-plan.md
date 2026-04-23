# autogap v0.1.0 — Launch Plan

Target date: **2026-05-13**

---

## What is in scope for v0.1.0 (GA)

| Area | Included |
|---|---|
| Core skill | SKILL.md — production-ready spec |
| Project type coverage | code, docs/research, strategy/business |
| Install | install.sh (macOS/Linux) + install.ps1 (Windows) |
| Examples | 3 demo projects with expected outputs |
| Case studies | 3 real diagnoses (1 public, 2 anonymized) |
| Design docs | design-rationale.md |
| CI | structural validator on demo outputs |
| Contributing | Full guide, PR process, style rules |
| License | MIT |

---

## What is out of scope for v0.1.0

| Area | Reason |
|---|---|
| Telemetry / run history | By design: no silent writes to user project |
| Web UI / SaaS | Violates awesome-list policy; increases attack surface |
| Non-English demo outputs | v0.2 target after collecting real runs |
| Semantic output validation (LLM-judged) | Requires Claude API key in CI; v0.2 target |
| Additional project type demos (creative, ops) | v0.2 once stable on 3 existing types |
| Update notifications | No feasible mechanism without telemetry |

---

## Launch checklist

- [ ] All items in CHANGELOG [0.1.0] present in repo
- [ ] CI passing on main
- [ ] `install.sh` and `install.ps1` tested on macOS + Linux + Windows
- [ ] README links all resolve
- [ ] Git tag `v0.1.0` created
- [ ] GitHub release published with CHANGELOG [0.1.0] as body

---

## Post-launch priorities (v0.2 candidates)

1. **Non-English demo output** — at least one Italian `autogap-run-it.md` per demo, validating the language-mirroring claim.
2. **Semantic output validation** — LLM-as-judge CI step that checks gap quality, not just structure.
3. **Creative / ops demo projects** — broaden coverage of the "any project type" claim.
4. **Comparison mode** — detect `.autogap-last.md` and produce a progress report (gaps closed, gaps remaining, new gaps).
