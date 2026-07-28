# Admin Dashboard API

Backend service powering the internal admin dashboard (report tables, account management tooling).

## Tech Stack

- **Runtime**: Node.js, Express for the REST API layer.
- **Database**: PostgreSQL, accessed via the `pg` driver (no ORM — hand-written queries in the repository layer).
- **Structure**: layered architecture — `routes/` (HTTP layer) -> `controllers/` -> `services/` (business logic) -> `repositories/` (data access).
- **Testing**: Jest for unit and integration tests, `supertest` for HTTP-level tests against Express routers.
- **Logging**: structured logging via `pino`.
- **Deployment**: containerized, deployed to AWS ECS behind an Application Load Balancer.
- **Background jobs**: long-running work (e.g. large report generation) is handed off to a worker process that polls a jobs table in Postgres — there is no separate message queue in this service today.

## Directory Layout

```
src/
  routes/
  controllers/
  services/
  repositories/
  jobs/
  middleware/
test/
```
