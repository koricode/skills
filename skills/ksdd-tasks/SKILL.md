---
name: ksdd-tasks
description: Breaks an existing product spec and tech spec into a sequenced, reviewable list of implementation tasks — one file per task, each an independently completable deliverable shipped with its own validation (tests, lint, contract checks) drawn from the project's real toolchain. Use whenever the user wants to turn a finished spec into actionable work — "break this into tickets", "what's the task breakdown", "let's plan the implementation steps for X", "give me a checklist to work through", or before handing a feature off to an engineer or another agent to build — even if they don't say "tasks" outright. Requires both a product spec (from ksdd-specify) and a tech spec (from ksdd-plan) to already exist for the feature. Do NOT use this to write the product spec or tech spec themselves, or to implement the code directly — those are separate phases this one builds on and hands off to.
---

# Create Implementation Tasks

## Procedure

**Step 1: Validate Prerequisites**
1. Confirm the feature slug has been provided or can be derived from context. If ambiguous, ask.
2. Verify the product spec exists at `./specs/[feature-slug]/product-spec.md`. If it's missing, stop and tell the user to run `ksdd-specify` first.
3. Verify the tech spec exists at `./specs/[feature-slug]/tech-spec.md`. If it's missing, stop and tell the user to run `ksdd-plan` first — task breakdown needs a settled HOW to sequence against, not just a WHAT.

**Step 2: Read Both Specs (Required)**
1. Read the product spec end-to-end. Extract the numbered functional requirements (FR-1, FR-2, ...) — every task you generate should trace back to one or more of these.
2. Read the tech spec end-to-end. Extract the component list, key interfaces, data models, build order (its own "Development Sequencing" section), and testing approach.
3. Note the tech spec's "Standards Conformance" section — it already names the project's real skills, conventions, and toolchain, so you don't need to rediscover them from scratch.

**Step 3: Confirm the Validation Toolchain (Required)**
1. Every task needs real validation steps, not generic placeholders like "run unit tests" — that means naming the project's actual test runner, lint command, and any architecture/contract-test tooling.
2. The tech spec's "Testing Approach" and "Standards Conformance" sections are the first source for this. If they already name concrete commands (e.g. a specific test runner invocation, a lint script), reuse them verbatim.
3. If the tech spec is thin here, check the same sources it would have (`package.json`/`pyproject.toml`/`build.gradle*`/etc. scripts, `CLAUDE.md`/`AGENTS.md`, `README.md`) before asking the user — don't invent a tool the project doesn't use.
4. If nothing concrete turns up anywhere, ask the user rather than guessing.

**Step 4: Generate the High-Level Task List (Required)**
1. Present the high-level task list to the user for approval BEFORE generating any files.
2. Group tasks by logical deliverable — a task is a coherent slice of the feature, not a single function or file.
3. Order tasks by real dependency, following the tech spec's own build order where it has one: data/domain before adapters, persistence before the integrations that depend on it, core implementation before end-to-end/final validation.
4. Each task MUST be a functional, incremental deliverable — something that could ship or be reviewed on its own, not a fragment that only makes sense once three other tasks also land.
5. Each task MUST carry its own validation relevant to what it builds (unit, integration, architecture/contract, lint — whatever Step 3 surfaced and applies to that task).
6. Cap the list at roughly 15 tasks — group related work under one task with subtasks rather than exploding it into many thin ones.
7. Wait for the user's approval before moving to Step 5. If they push back, revise using their feedback and re-present rather than proceeding on a guess.

**Step 5: Generate Task Files (Required)**
1. Read the summary template at `assets/tasks-template.md` and the individual task template at `assets/task-template.md`.
2. Create the directory `./specs/[feature-slug]/tasks/`.
3. Write the summary file to `./specs/[feature-slug]/tasks.md`.
4. Write one file per top-level task to `./specs/[feature-slug]/tasks/[N]_task.md` (e.g. `1_task.md`, `2_task.md`), where `N` matches the task's number.
5. Use `X.0` for the main task heading and `X.Y` for its subtasks, all inside that one file.
6. Do NOT restate implementation details already decided in the tech spec — reference the relevant section instead (e.g. "see tech-spec.md § Data Models"). A task file that copies the tech spec loses its single source of truth the moment one of them is edited later.

**Step 6: Report Results**
1. List every file generated, with paths.
2. Wait for the user's confirmation before treating any task as ready to implement.

## Core Principles
- A task answers "what, in what order, and how do I know it's done" — not "how is it built." Re-deriving design belongs to the tech spec; if a task file is explaining an interface or schema rather than pointing at one, cut it.
- Give each requirement and each design decision a single source of truth: reference the product spec's FR-N or the tech spec's section instead of restating it.
- Real validation beats a generic checklist item — name the project's actual test/lint/contract-check commands (Step 3), because "write tests" tells the next implementer nothing they didn't already know.
- Sequence by real dependency, not by document order in the tech spec — domain and persistence before the integrations and UI layered on top, implementation before final end-to-end validation.
- Each task should be independently completable: a developer or agent picking up just that one file, plus the specs it references, should have everything they need.

## Error Handling
- If `product-spec.md` is missing, stop and point the user to `ksdd-specify`.
- If `tech-spec.md` is missing, stop and point the user to `ksdd-plan`.
- If the user rejects the high-level task list, revise it based on their feedback and re-present for approval — don't generate task files against an unapproved list.
- If `./specs/[feature-slug]/tasks.md` or the `tasks/` directory already has content, confirm with the user before overwriting.
