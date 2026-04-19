# Case study 02 — AI Coach fine-tuning for a healthcare vertical

> **Real anonymized Arenia engagement.** Client profile, gap pattern, and retention outcome preserved; specific training-provider and healthcare-client identities redacted.

- **Date:** 2026 Q1
- **Client of Arenia:** B2B sales training provider
- **End vertical being served:** healthcare
- **Project type:** AI / product tuning + measurable user-impact hybrid
- **Trigger:** fine-tuning of Arenia's AI Coach for the healthcare vertical was failing to produce usable sessions
- **Outcome:** measurable AI Coach hit-rate lift on healthcare scenarios; sharper on-topic behavior; **user retention up 17%.**

---

## Context

One of Arenia's platform customers is a B2B sales training provider. They had sold a custom AI Coach programme into a healthcare-vertical end client, with scenarios tailored to healthcare sales conversations (specialty pharma detailing, clinical discussion handling, objection cycles around evidence and regulation).

The healthcare end client started the programme and gave early feedback: sessions felt repetitive, the Coach mishandled domain-specific objections, and perceived latency during the sessions was hurting engagement. Usage was dropping.

The training provider escalated to Arenia. The ask was clear: **fix the AI Coach on this vertical, fast, or the renewal conversation becomes very hard**. Arenia ran a technical diagnosis before proposing changes — this is what `autogap` output.

## The artifact bundle `autogap` ran on

- AI Coach session transcripts from the first weeks of the programme.
- The prompt configuration for the healthcare scenarios deployed.
- Platform telemetry: per-session latency distribution, response-length distribution, user-abandonment points.
- User feedback captured in-app after each session (numeric rating + free text).
- The healthcare client's onboarding brief: tone, regulatory sensitivity, key objections to handle.

## Objective hypothesis, inferred

> Make the AI Coach trustworthy and usable enough on the healthcare vertical that the training provider's end-client renewal conversation is defensible on measurable usage and behavior-change data.

**Confidence:** High.

Signals: session data is already being collected (intent = measurable); the training provider escalated proactively rather than letting it slide (= renewal is the real clock); in-app feedback is structured around trust / realism / usability (= those are the renewal dimensions).

**Strongest alternative:** "Redesign the scenarios from scratch" — real option but higher risk on the timeline. Ruled out at this stage in favour of targeted fixes.

## Current state summary

The scenario design and prompt configuration are well-built as general-purpose conversational coaching. Under a high-stakes domain with rigid semantic expectations (healthcare sales), three specific failure modes surface in the transcripts. None are architectural; all three are fixable inside the existing Arenia platform without a rebuild.

## Top 3 gaps

### Gap 1 — Low variance in AI Coach responses

Across the session transcripts, the same user-initiated pattern produced near-identical Coach replies. Users practicing the same scenario twice felt they had already "beaten" it on round 2. This is a training-data and prompt-level issue, not a model-capability issue: the scenario prompts over-constrained the Coach into a narrow response manifold.

**Why top-3:** repeated practice is the whole value proposition of simulation-based coaching. If the simulation feels repetitive, users disengage by design.

### Gap 2 — Semantic flaw in handling of domain objections

The Coach's objection-handling in healthcare-specific contexts (evidence quality, regulatory risk, payer-specific arguments) was grammatically correct but semantically off. The Coach frequently accepted the user's premise as stated, rather than probing assumptions that a trained healthcare sales mentor would have challenged. This made the sessions feel supportive but not sharpening.

**Why top-3:** this is the single biggest trust-transfer dimension for the end client. A coach that accepts flawed premises is not coaching — it's validating. Senior healthcare sales people spotted this in under one session.

### Gap 3 — Latency bug: response-time lag growing across the session

Platform telemetry showed response latency increasing during the session rather than staying constant. Sessions that started snappy ended noticeably slower by turn 10-12. Users felt "the Coach gets slower the more I use it", which is both a literal bug and a psychological trust-killer.

**Why top-3:** lag interrupts the conversational flow that the Coach depends on to feel realistic. Even with perfect content, a degrading-latency session reads as broken.

## 3 macro-steps

### Macro-Step 1 — Response-variance diversification

- **Goal:** round-2 users encounter recognisably different Coach responses on the same scenario.
- **What changes:** scenario prompt restructured to expose a larger response manifold; training-data augmentation for the healthcare scenarios with domain-appropriate variations; regression pass to ensure baseline behaviors are preserved.
- **Complexity:** Medium · **Value:** High · **Confidence:** High

### Macro-Step 2 — Objection-handling semantic fix

- **Goal:** the Coach probes flawed user-premise assumptions in healthcare objections rather than accepting them.
- **What changes:** prompt restructure to instruct the Coach to challenge rather than accept; domain-specific objection pattern library added for healthcare; A/B regression over replay transcripts to confirm the new behavior does not introduce aggression or off-tone responses.
- **Complexity:** Medium-High (tone is the risk) · **Value:** Very High · **Confidence:** Medium-High

### Macro-Step 3 — Latency: profile and fix the within-session degradation

- **Goal:** response latency is constant across session length rather than climbing with turn number.
- **What changes:** latency profiling across the conversation stack (context construction, retrieval, generation, post-processing); fix on the accumulator path that was retaining session history past its useful window; release a platform patch.
- **Complexity:** Low (once profiled) · **Value:** High · **Confidence:** High

## Recommended execution order

**3 → 1 and 2 in parallel.**

The latency fix (Macro-Step 3) goes first because it's a pure platform change that benefits every Arenia customer, not just this engagement. Macro-Steps 1 and 2 are scenario-level and run in parallel afterwards: they share the same regression infrastructure but touch different axes (variance vs. objection semantics). A joint regression pass at the end validates that variance didn't break objection handling and vice versa.

## What happened

Fine-tuning sprint ran over the course of about a month. Three workstreams as above; close cadence during the middle weeks when all three were live.

- **Macro-Step 3** released first as a platform patch; immediate drop in late-turn latency across all customers (not only this one).
- **Macro-Step 1** completed second: scenario prompts rewritten, training data augmented, regression clean.
- **Macro-Step 2** completed last and took the longest — tone calibration over objection-challenging turned out to be the hard part. Multiple iterations before the A/B regression stabilised. Final prompts ship with explicit instructions to challenge without antagonising, validated on a domain-expert review panel.

The healthcare end client saw the changes land over weekly releases. Mid-point feedback was already positive ("finally it pushes back"). By end of month, the training provider was reporting organically rising session counts.

## Outcomes

- **Measurable hit-rate lift on AI Coaching.** The three changes compounded: users rated sessions as more realistic, more challenging, and more responsive. Exact hit-rate numbers retained by Arenia.
- **Sharper on-topic focus.** The Coach now stays inside the intended simulation's scope rather than drifting to general coaching platitudes.
- **User retention up 17%** on the healthcare programme over the following 30 days, measured against the pre-fix baseline. This was the headline metric that unlocked the renewal conversation.

## What `autogap` did well

- **Refused to recommend a redesign.** The obvious consultant move on "it feels repetitive and slow" is "start over". `autogap` resisted and ranked three concrete, in-platform fixes that were executable inside the renewal timeline.
- **Separated platform-wide from scenario-specific.** The latency bug was a platform gap that happened to surface here; it got ranked as its own macro-step and released to all customers — a durable win from a single-customer engagement.
- **Called out the objection-handling tone calibration as the riskiest step.** The confidence rating on Macro-Step 2 was "Medium-High" specifically because tone is hard, and it turned out to be the workstream that needed the most iterations. The honest confidence calibration upfront made the project timeline defensible.

## What we learned

- **Semantic-off in a Coach feels worse than grammatically wrong.** Users accept AI saying something awkwardly; they disengage when the AI agrees with a flawed premise. Objection handling is where domain trust is won or lost.
- **Latency degradation within a session is a distinct product bug class** that generic latency SLOs don't catch. Measuring distribution across turn-number, not just overall average, should be standard.
- **A single-customer engagement can produce platform wins.** The latency patch benefitted every Arenia customer. The instinct to scope tightly around the paying customer is often wrong; the best engagements leave the platform better than they found it.

---

*Published with Arenia engagement-policy approval. Specific training-provider and healthcare-client identities redacted; outcome metric (retention +17%) verified.*
