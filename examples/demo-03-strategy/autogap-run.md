# `/autogap` — expected output

This is the diagnosis `autogap` produces when invoked on `examples/demo-03-strategy/`. Reproduce with:

```bash
cd examples/demo-03-strategy
claude
> /autogap
```

---

# Project Objective Hypothesis

- **Launch ProductX v2.0 on 2026-09-15 without churning the top-3 LOI accounts whose contracts are contingent on timing.**
- **Project type:** strategy / business · product launch
- **Confidence:** High
- **Signals:**
  - `plan.md`: launch date, €180k budget, top-3 LOI contingency explicitly named.
  - `okrs.md` Objective 1: *"Launch v2 with minimal churn"* — first OKR, primary metric churn.
  - Beta feedback (`signals/beta-feedback-survey-raw.md`) is structurally concentrated on barriers to conversion — not on v2 as a product.
  - `gtm-draft.md` positioning still unsettled; reference customers 0/3 signed.
- **Alternative hypothesis:** "Establish usage-based pricing as a category" (Objective 2) — real but secondary; doesn't override the Q3 date contingency.
- **Confidence on primary:** High.

# Current State Summary

Five months to launch. Engineering is on track (Giulia confirmed). The launch-readiness risk is concentrated outside engineering: the marketing lead role is vacant, reference customers are short, beta cohort feedback converges on a UX problem (pricing clarity) that is not yet owned, OKR3 is empty, and legal has not been engaged on pricing-page copy. None of these is fatal individually; together they compound into a launch that ships on date but loses the top-3 accounts it was designed to keep.

# Top 3 Gaps

## Gap 1 — Marketing lead role unfilled, 4 months before launch
- **Why matters:** a public launch with PR wave, Product Hunt, landing page, analyst briefings, case studies, and positioning pivot cannot execute without a single owner for external comms. The role has been vacant since March.
- **Evidence:** `stakeholders.md`: *"Marketing lead — NOT STAFFED. Was Paolo; left in March. Contractor shortlist not reviewed."* `plan.md` owner: *"[TBD — likely Marco, pending confirmation]"* — even internal owner unsettled.
- **Consequence if ignored:** either the launch slips, or it ships without proper external execution (positioning confused, PR flat, landing page weak). The top-3 accounts see a wobbly launch and exercise their LOI escape clauses.
- **Why top-3:** this is a single-point-of-execution gap. No amount of alternative effort closes it.

## Gap 2 — Reference customers short: 0 signed, 2 in flight, need 3 by Sept 1
- **Why matters:** positioning, PR, landing page, analyst briefings (OKR 2) all need named customers. Zero signed with 4 months left is a slow crisis. The two in-flight cases typically take 6-8 weeks each from first conversation to signed final.
- **Evidence:** `gtm-draft.md`: *"Need 3 signed case studies by Sept 1. Currently: 0 signed, 2 in flight."* Beta cohort: 20 accounts, 8 responded to feedback survey — 3 gave positive ROI signals that could be converted to references if pursued now.
- **Consequence if ignored:** launch ships without named customers; analyst briefings get soft treatment; landing-page conversion hypothesis (OKR 2 KR 3: >2%) misses.
- **Why top-3:** hard external dependency with long cycle time; cannot be crammed in the last month.

## Gap 3 — Pricing clarity is the converging beta signal, and it has no owner
- **Why matters:** 4 of 8 beta survey responses touch pricing understanding (not price level — understanding). Migration friction and ownership confusion are adjacent signals. If the top-3 LOI accounts convert to v2 and then hit a bill they didn't expect in month 2, they churn and the launch fails its primary OKR.
- **Evidence:** `signals/beta-feedback-survey-raw.md`: *"Pricing calculator on the landing page is confusing"*, *"We tried self-serve migration and hit a snag on users with mid-month plan changes"*, *"Who's my point of contact?"*. `plan.md` Known Unknowns lists pricing-page copy (legal review not scheduled) and billing edge cases.
- **Consequence if ignored:** high risk of KR 1 (churn <5%) missing. Top-3 accounts have signed LOIs but signed nothing about *staying*.
- **Why top-3:** unlike the first two gaps, this is a latent time-bomb — cheap to fix now, expensive to fix in October.

# 3 Macro-Steps

## Macro-Step 1 — Staff marketing lead within 10 days
- **Goal:** contractor or full-time, with signed scope, starting no later than 2026-05-02.
- **What changes:** review the existing contractor shortlist this week; interview 3 top candidates next week; scope a 4-month engagement; sign. Budget: pull from the €45k unassigned.
- **Complexity:** Low (operational, not creative) · **Expected value:** Very High · **Confidence:** High (depending on contractor availability, but risk is containable).

## Macro-Step 2 — Reference customer sprint: 2 signed by May 30 + 1 more by July
- **Goal:** 3 signed case studies by September 1, compatible with the launch narrative.
- **What changes:** expedite the 2 in-flight cases through legal and approvals on the customer side. Identify the 3rd candidate from the beta survey respondents flagged as positive ROI (account #11 in the signal data). Assign a dedicated marketing-lead owner (depends on Macro-Step 1).
- **Complexity:** Medium · **Expected value:** High · **Confidence:** Medium (customer-side cycle times are not fully controllable).

## Macro-Step 3 — Pricing clarity sprint based on beta feedback
- **Goal:** the 4 "I don't understand what I'll pay" beta respondents understand it after the redesign.
- **What changes:** one-week sprint: redesign the pricing calculator UX, write a pricing explainer (landing page + email), add scenario examples at 2x / 5x / 10x current usage. Test with 5 of the 8 beta responders in a 1-hour call each before landing-page copy is frozen. Close the loop with a written FAQ that addresses the v1.5 sunset question.
- **Complexity:** Medium · **Expected value:** High · **Confidence:** Medium-High

# Recommendation

**Order:** 1 first (now) → 2 and 3 in parallel once 1 is filled.

Macro-Step 1 is the gating dependency for Macro-Step 2 (the marketing lead owns the reference-customer sprint) and accelerates Macro-Step 3 (pricing page copy + positioning). Without 1 filled, neither 2 nor 3 execute well. Delaying 1 by another 4 weeks compresses the entire launch into September, which is where 80% of the visible public-facing mistakes happen.

# User Choice

Choose what to implement:

1. Macro-Step 1 only — fill the role; let 2 and 3 land naturally after
2. Macro-Step 2 only — push reference cases; marketing still unfilled (fragile)
3. Macro-Step 3 only — fix pricing clarity; other gaps remain
4. Macro-Steps 1 + 2 — staff and chase customers; defer pricing polish
5. Macro-Steps 1 + 3 — staff and fix pricing; customers slip
6. Macro-Steps 2 + 3 — execute without a lead (highest execution risk)
7. All three — full launch readiness
8. None now; refine diagnosis

*Typical pick:* **1 now, then 7** in a two-step flow.
