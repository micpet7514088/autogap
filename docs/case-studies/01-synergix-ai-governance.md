# Case study 01 — AI Act readiness diagnosis, European insurtech mid-cap

> **[DRAFT — anonymized, pending final user verification of metrics.]** Based on a real Synergix engagement. Sector and order-of-magnitude details preserved; identifying data obscured.

- **Date:** 2026 Q1
- **Sector:** European insurtech
- **Client size:** ~600 employees · ~8 AI tools in various stages (2 in production, 3 in POC, 3 shadow/departmental)
- **Project type:** strategy + compliance hybrid
- **Outcome:** governance checkpoint passed; 5 vendor contracts renegotiated with AI-specific addenda.

---

## Context

A mid-cap European insurtech approached Synergix after an internal compliance review flagged that the company had no consolidated answer to the question "which of our AI systems fall under the EU AI Act high-risk provisions, and what do we need to do before February 2027?".

Management had commissioned three separate pieces of analysis over the previous twelve months (one from the internal legal team, two from different external consultancies). The outputs contradicted each other on scope and did not agree on a single inventory. The CTO's office had a broad AI strategy deck from 2024 that predated the final AI Act text.

The ask was **not** "draft an AI policy" — the company had multiple drafts already. The ask was "diagnose what's actually blocking readiness, and tell us what to fix first".

Synergix ran `autogap` on the consolidated artifact bundle the client provided:

- The 2024 AI strategy deck (42 slides).
- The three analyses from legal and external consultancies (combined ~180 pages).
- The 5 most relevant vendor contracts (insurance-claims vendor, chatbot vendor, OCR vendor, internal analytics, customer-segmentation tool).
- Architecture diagrams of the 8 AI tools.
- The existing data-protection impact assessment (DPIA) template library.
- Board-level risk committee minutes covering AI topics (last 18 months).

## Objective hypothesis, inferred

> Reach demonstrable AI Act readiness by Q4 2026, 60+ days ahead of the February 2027 high-risk provisions deadline, such that any vendor due diligence, board audit, or regulator inquiry is answerable from an internal source of truth.

Confidence: **High.**

Strongest alternative: "Produce a competitive AI roadmap for board approval" — also in play, but the AI Act deadline was the hard external forcing function.

## Top 3 gaps

### Gap 1 — No single AI system inventory

Three overlapping, contradicting inventories across legal, IT, and business. No canonical list of deployed AI systems. Classification against AI Act risk tiers therefore impossible at the source. Any future regulatory request starts with weeks of reconciliation.

### Gap 2 — No assigned AI governance contact + RACI is implicit

The AI Act requires an identifiable internal contact for high-risk AI systems. The company had none. Decision rights on AI were split informally across CTO, CRO, and HR (for employee-facing tools) with no escalation path. Vendors sent AI-related queries to whichever internal contact they knew; responses diverged.

### Gap 3 — Vendor contracts do not cover AI-specific obligations

The 5 reviewed contracts were standard software-vendor templates. None referenced: AI transparency obligations, model-card disclosure, data used for training vs. inference, drift monitoring responsibilities, or incident notification for AI-specific failures. Under the AI Act, several of these become legally required for high-risk deployments, pushing compliance risk onto the buyer by default.

## 3 macro-steps

### Macro-Step 1 — Mandatory AI inventory with risk-tier classification

Produce one canonical inventory with, per system: purpose, data classes used, vendor (if any), risk tier classification, responsible business owner, deployment status.

**Complexity:** Medium · **Value:** High · **Confidence:** High.

### Macro-Step 2 — Governance charter with explicit RACI and escalation

One-page charter identifying AI Act contact, decision rights per system risk tier, escalation to risk committee, link to existing DPIA process.

**Complexity:** Low · **Value:** High · **Confidence:** High.

### Macro-Step 3 — Vendor contract addenda for in-production AI systems

Starting from the 2 production and 3 most advanced POC vendors: draft and negotiate AI-specific addenda covering transparency, training-data disclosure, and incident obligations.

**Complexity:** High · **Value:** Medium · **Confidence:** Medium (negotiation-dependent).

## Recommended execution order

1 → 2 → 3.

The inventory (1) feeds both the governance charter (2) and the vendor addenda (3). The charter (2) needs to be drafted before the addenda negotiations so that internal authority is clear during vendor discussions. The addenda (3) is the longest-tail and highest-risk-of-slippage item, so starting it with an agreed internal position reduces cycle time.

## What happened

Synergix led the six-week engagement. Macro-Step 1 completed in 2 weeks with the inventory produced jointly with IT and legal. Macro-Step 2 completed in 1 week with board sign-off. Macro-Step 3 produced 5 renegotiated contracts over the remaining 3 weeks, with one vendor requiring escalation to their product team (delay absorbed in the overall timeline).

The canonical inventory became the input for the next board AI risk review; the governance charter was adopted as the base for the AI Act compliance plan.

## Metrics (to be verified)

> **[PLACEHOLDER — pending user confirmation of the real numbers before publication.]**
> Suggested fields: number of AI systems reclassified, number of DPIAs triggered by the new inventory, number of vendor addenda signed, time-to-answer for board AI risk questions (before vs. after).

## What `autogap` did well

- **Refused to treat this as a "draft a policy" project.** Three policy drafts already existed and contradicted each other. The real gap was at the layer below (inventory, RACI, contracts), and `autogap` ranked it that way.
- **Separated governance from technical work.** The 8 AI tools had real technical debt that was out of scope for AI Act readiness. That debt did not make the top-3 — correctly, given the objective.

## What we learned

- For regulated-industry clients, "what's blocking" is almost always more useful than "what's possible". `autogap`'s blocker-strength ranking aligned naturally.
- One-page governance deliverables were accepted by the board in a single meeting. A 30-page policy draft had been stuck in revision for six months.

---

*This case study is marked DRAFT pending the client's public-disclosure review. Metrics and intervention details will be finalized before the autogap public launch.*
