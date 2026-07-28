---
name: ksdd.specify
description: Creates a Product Specification (product spec / PRD) — the foundational "what and why" document that planning and implementation work builds on. Use whenever the user asks to write a product spec, PRD, or requirements doc for a new feature, product, or capability, or wants to scope/define one before anyone starts building — even if they don't say "spec" or "PRD" outright (e.g. "let's nail down what's actually being built for X", "the requirements for this need to be written down"). Do NOT use this for technical/engineering specs, system architecture, or task/implementation breakdowns — those belong to a later phase and assume this spec already exists.
---

# Create Product Specification

## Procedure

**Step 1: Confirm the Basics**
1. Confirm the feature, product, or capability name has been provided. If it's vague ("a new dashboard thing"), ask for a short working name before continuing.
2. Derive a kebab-case slug from it for the output directory: `./specs/[feature-slug]/`.

**Step 2: Clarify Requirements (Required)**
1. Before drafting anything, ask the user clarifying questions — use whatever question-asking tool is available in the current environment, or ask directly in conversation if none is.
2. Work through these areas, but only ask about what isn't already answered by the conversation so far:
   - **Problem & Goals** — What problem does this solve, for whom, and what does success look like? Any measurable targets?
   - **Users & Stakeholders** — Who uses this directly (end users, internal teams, other systems/services), and who else is affected or has a stake in the outcome?
   - **Core Functionality** — What are the key inputs, outputs, states, and business rules? What must be true for this to be considered "done" (acceptance criteria)?
   - **Scope & Sequencing** — What's explicitly out of scope for this version? What does it depend on? Is this a full launch, a phased rollout, or a prototype?
   - **Constraints** — Any hard requirements around performance, security, compliance, data privacy, cost, platform, or timeline?
3. Do not move on to Step 3 until you have real answers here, not assumptions. If the user says "you decide" or "use your best judgment" on a specific point, that counts as an answer — note the assumption explicitly in the spec rather than blocking on it.

**Step 3: Plan the Spec (Required)**
1. Sketch a short plan before writing prose:
   - Which sections need the most attention given what you just learned.
   - Anything worth researching first (unfamiliar domain, competitor behavior, a technical constraint worth verifying) — use a research tool if one is available.
   - Assumptions you're making and open dependencies.
2. Share the plan with the user so they can redirect before you spend effort drafting the wrong thing.

**Step 4: Draft the Spec (Required)**
1. Read the template at `assets/product-spec-template.md` in full and follow its structure — don't skip or reorder sections.
2. Write for WHAT and WHY, not HOW. Implementation approach, architecture, and technical design belong to a later planning/tech-spec phase, not here — if you catch yourself specifying *how* something is built, cut it or move it to a "known constraints" note.
3. Give the "Core Features" section numbered functional requirements (FR-1, FR-2, ...) — later planning work will need to reference these individually.
4. Keep the whole document under ~2,000 words. A spec people won't read is worth less than a shorter one they will.
5. Write in the vocabulary of the actual product/domain the user described — don't leave placeholder-sounding generic text in the final draft.

**Step 5: Save the Spec (Required)**
1. Create the directory: `./specs/[feature-slug]/`.
2. Save the document to: `./specs/[feature-slug]/product-spec.md`.

**Step 6: Report Results**
1. Report the final file path.
2. Give a short summary of what the spec covers and flag anything you had to assume.

## Core Principles
- Prefer measurable, falsifiable statements over vague ones ("page loads in under 2s" beats "page loads fast").
- Make dependencies on other systems, teams, or in-flight work explicit rather than implied.
- Optimize for a reader who wasn't in the room for the clarifying conversation — they should be able to pick up the spec cold.
- Give each requirement a single source of truth: state it once as a numbered FR and reference that number elsewhere (e.g. in User Experience or Constraints) instead of restating it — a spec that says the same thing twice will eventually say it two different ways.

## Error Handling
- If the user's context is too thin to answer the clarifying questions, ask follow-ups before proceeding — don't fill gaps with invented specifics.
- If the template file is missing, report the error and stop rather than improvising a structure from memory.
- If the output directory already exists with content in it, confirm with the user before overwriting.
