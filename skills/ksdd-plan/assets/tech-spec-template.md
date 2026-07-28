# Technical Implementation Plan: [Feature/Product Name]

## Executive Summary

[Give a brief technical overview of the solution approach in 1-2 paragraphs. Summarize the key architectural decisions and implementation strategy. Note which product spec functional requirements (FR-N) this plan addresses.]

## System Architecture

### Component Overview

[Briefly describe the main components and their responsibilities:

- Component names and primary functions — list every component that is new or will be modified
- Key relationships between components
- Data flow overview]

## Implementation Design

### Key Interfaces

[Define the main interfaces/contracts, in the project's actual language and style (≤20 lines per example):

```
// Use the project's real language/framework here — this is illustrative only
interface SaveOrderUseCase {
    execute(command: SaveOrderCommand): Order
}
```
]

### Data Models

[Define the essential data structures:

- Core domain entities (if applicable)
- Request/response types
- Database schema changes (if applicable)]

### API / Interface Contracts

[List API endpoints or async contracts if applicable:

- Method and path (e.g. `POST /api/v1/resource`) or equivalent RPC/CLI/event signature
- Brief description
- Request/response format references
- Events produced or consumed (queue/topic/webhook), if applicable]

## Integration Points

[Include only if the feature requires external integrations:

- External services or APIs
- Queues, topics, or internal events
- Authentication requirements
- Error handling, retry, and idempotency approach]

## Testing Approach

### Unit Tests

[Describe the unit testing strategy:

- Core components to test
- Mocking requirements (external dependencies only)
- Adherence to the project's established test conventions (from Step 3/7)
- Critical test scenarios]

### Integration Tests

[If needed, describe integration testing:

- Components tested together
- Test data requirements
- Test infrastructure used (e.g. containerized dependencies), matching what the project already uses]

### Architecture / Contract Tests

[If applicable, describe architectural or contract-level testing:

- Impact on existing architecture/lint rules
- API, event, or persistence contracts that need validation]

## Development Sequencing

### Build Order

[Define implementation sequence:

1. First component/feature (why first)
2. Second component/feature (dependencies)
3. Subsequent components
4. Integration and testing]

### Technical Dependencies

[List any blocking dependencies:

- Required infrastructure
- External service availability
- Migrations, schema changes, feature flags, or credentials needed]

## Monitoring and Observability

[Define the monitoring approach using the project's existing tooling:

- Metrics to expose
- Key logs and log levels
- Relevant dashboards or alerts
- Tracing, alerting, or audit strategy]

## Technical Considerations

### Key Decisions

[Document important technical decisions:

- Approach chosen and rationale
- Trade-offs considered
- Alternatives rejected and why]

### Known Risks

[Identify technical risks:

- Potential challenges
- Mitigation approaches
- Areas needing further research or explicit gaps left by missing architecture context]

### Standards Conformance

[List the skills, ADRs, or project docs that guided this plan (e.g. `.claude/skills/`, `.agents/skills/`, `CLAUDE.md`/`AGENTS.md`, architecture docs), and note any deliberate deviations with justification.]

### Requirements Coverage

[Map each addressed FR-N from the product spec to where it's covered in this plan.]

### Relevant Files

[List relevant and dependent files this plan touches or introduces.]
