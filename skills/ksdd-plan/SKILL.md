---
name: ksdd-plan
description: Creates a Technical Implementation Plan (tech spec) that translates an existing product spec's requirements into concrete engineering decisions, grounded in the project's real architecture rather than an invented stack. Use whenever the user wants the technical/engineering design for a feature that already has a product spec — even if they don't say "tech spec" outright (e.g. "how should we actually build this", "let's figure out the architecture for X", "I need an engineering design doc before sprint planning", "what's the technical approach here"). Do NOT use this to write the product spec/PRD itself (use ksdd-specify first), to break work into individual tickets/tasks, or to write implementation code directly.
---

# Create Technical Implementation Plan

## Procedure

**Step 1: Validate Prerequisites**
1. Confirm the feature slug has been provided or can be derived from context. If ambiguous, ask.
2. Verify the product spec exists at `./specs/[feature-slug]/product-spec.md`. If it's missing, stop and tell the user to run `ksdd-specify` first — this skill designs HOW to build something whose WHAT and WHY should already be settled.

**Step 2: Read the Product Spec (Required)**
1. Read the product spec end-to-end before extracting anything from it.
2. Extract the numbered functional requirements (FR-1, FR-2, ...), goals, and high-level constraints.
3. Note any assumptions the product spec already flagged — those are inputs here, not open questions to re-litigate.

**Step 3: Establish Architecture Context (Required)**
This is the step that keeps the plan honest. A tech spec is only as good as the real constraints it's grounded in, and this skill has no built-in opinion about language, framework, or architectural style — that opinion has to come from the project itself.
1. Search the repository for existing architecture context before asking anyone anything: `CLAUDE.md` / `AGENTS.md`, `ARCHITECTURE.md`, `docs/architecture/**`, `docs/adr/**` or `adr/**` (Architecture Decision Records), a tech-stack section in `README.md`, and dependency manifests (`package.json`, `pyproject.toml`/`requirements.txt`, `go.mod`, `pom.xml`/`build.gradle*`, `Cargo.toml`, `*.csproj`, etc.) to infer language, framework, and tooling.
2. If this content exists, read it and extract: language/framework, architectural style (e.g. layered, hexagonal, microservices, event-driven), module/service boundaries, established conventions, testing patterns, and deployment/observability tooling.
3. If what's discoverable is thin or absent — e.g. a greenfield repo, or one with no documented architecture — ask the user directly before drafting anything. Cover: tech stack and frameworks, architectural style and module boundaries, existing conventions or an ADR to follow, testing approach, and deployment/observability tooling. It's fine if the answer is "there's no established pattern yet, use your judgment" — but that has to be a stated decision, not a silent guess.
4. Never invent a stack, framework, or pattern that isn't backed by something you found or something the user told you. If you're proposing a new library or pattern the project doesn't already use, say so explicitly and justify it rather than presenting it as the existing convention.

**Step 4: Explore the Codebase (Required for brownfield work)**
1. If code already exists, explore the source tree to find the files, modules, interfaces, and integration points relevant to the FRs from Step 2.
2. Map the symbols, dependencies, and critical paths a change here would touch.
3. Check adherence to whatever conventions Step 3 surfaced.
4. If this is greenfield work with no existing code to explore, skip this step and rely on the architecture context from Step 3 plus your own judgment about a clean structure.

**Step 5: Research (as needed)**
1. Treat the repository and its own docs as the primary source of truth — prefer them over general knowledge.
2. Use a web search only to resolve a genuine, specific open question about a framework, library, or pattern the project actually uses (per Step 3) — not to explore alternatives to the established stack.
3. Finish research before moving to clarifying questions, so those questions are informed rather than exploratory.

**Step 6: Technical Clarifications (Required)**
1. Ask focused clarifying questions — use a structured question tool if one is available, otherwise ask directly in conversation. Cover whatever Steps 2-5 left open, such as:
   - Where this fits in the existing domain/module boundaries.
   - Data flow: what triggers it, what it reads/writes, what it produces.
   - External dependencies or services it needs to call or be called by.
   - The key interfaces or contracts other code will depend on.
   - Test scenarios that matter most (including failure/edge cases).
   - Rollout strategy, observability needs, and operational concerns (feature flags, backfills, migrations, retries).
2. Don't move on to drafting until these are answered, or the user has explicitly said to use your best judgment on a specific point.

**Step 7: Map Standards Conformance (Required)**
1. Identify project-level skills or docs that apply to this work — check `.claude/skills/`, `.agents/skills/`, and whatever convention docs Step 3 found.
2. Note where the planned approach follows those conventions, and flag any deliberate deviation with a reason and the compliant alternative that was considered.

**Step 8: Draft the Plan (Required)**
1. Read the template at `assets/tech-spec-template.md` in full and follow its structure — don't skip or reorder sections.
2. Write for HOW: if you catch yourself restating a requirement instead of designing for it, cut it.
3. Reference the product spec's FR numbers (e.g. "supports FR-2, FR-4") rather than restating requirements in prose.
4. Keep the prose under ~2,000 words — code blocks (interfaces, SQL, commands) don't count against this budget, so don't compress or skip them to stay under it. Depth should go into decisions and interfaces, not padding.
5. Write every example — interfaces, schemas, commands — in the project's actual language and toolchain from Step 3. If none is established yet, say so and pick something reasonable, explicitly flagged as a proposal.
6. Show, don't describe: wherever the feature touches persisted data, include the real SQL — `CREATE TABLE`/migration DDL and the key queries the feature will run — not a prose summary of the schema. The same goes for any other non-trivial logic: a short code snippet pins down exactly what gets built, where a paragraph leaves it open to reinterpretation once ticket-writing and implementation take over downstream.
7. Prefer existing libraries and patterns already used in the project over introducing new ones, unless there's a real gap they don't cover — and justify the exception if you do.
8. Give validation/test commands that match the real toolchain discovered in Step 3 (e.g. the project's actual test runner and build tool) rather than a generic placeholder.

**Step 9: Save the Plan (Required)**
1. Save the document to `./specs/[feature-slug]/tech-spec.md`.
2. If a file already exists at that path, confirm with the user before overwriting.

**Step 10: Report Results**
1. Report the final file path.
2. Summarize the core architectural decisions in a few sentences, and flag anything drafted on an explicit assumption rather than confirmed fact.

## Core Principles
- The tech spec is about HOW, not WHAT or WHY — those belong to the product spec this builds on.
- Ground every technical decision in the project's real architecture (Step 3) — never an invented stack.
- Give each requirement a single source of truth — reference the product spec's FR-N rather than restating it.
- Prefer simple, evolvable architecture with clear interfaces over clever or speculative design.
- Build in testability and observability from the start, using the project's existing tooling rather than proposing new tooling by default.
- Prefer libraries and patterns the project already uses over custom or novel solutions.
- Show, don't describe: real code and SQL (Step 8.6) carry more signal into task breakdown and implementation than prose descriptions of the same thing.

## Error Handling
- If `product-spec.md` doesn't exist at the expected path, stop and tell the user to create it with `ksdd-specify` first.
- If no architecture context can be found and the user's answers to Step 3 still leave a real gap, record the gap explicitly in the plan (e.g. under Known Risks) rather than filling it with an invented detail.
- If a research question remains after checking project docs, use a web search narrowly scoped to that one question — not a general survey of the space.
- If the output file already exists, confirm with the user before overwriting it.
