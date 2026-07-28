# Product Specification: Admin Dashboard CSV Export

## Overview

Internal admin users (support and finance teams, ~40 people) currently ask the data team to manually pull CSVs from report tables in the admin dashboard — about 15 requests a week. This feature lets admins export any report table they can already see as a CSV themselves, self-serve.

## Goals

- Eliminate the majority of manual CSV pull requests to the data team (currently ~15/week).
- Admins can export a report of under 5,000 rows and have the file in hand within 3 seconds.
- 80% of eligible admin users have used self-serve export within the first month of launch.

## Users & Stakeholders

- Primary: internal admin users on the support and finance teams who currently view report tables in the admin dashboard.
- Secondary: the data team, who today absorb these requests manually and would be freed up.
- Secondary: compliance/security, who care that exports of potentially sensitive data are auditable.

## Core Features

**CSV Export from Report Tables**
- Adds an "Export CSV" action to any existing report table view in the admin dashboard.
- FR-1: Admin users can trigger a CSV export directly from any report table view via an "Export CSV" button.
- FR-2: The exported file respects whatever filters and sort order are currently applied to the table on screen — it is not always a full unfiltered dump.
- FR-3: The exported file contains the same columns currently visible in the UI for that report.
- FR-4: For datasets larger than 5,000 rows, the export is handled asynchronously and the admin is notified (in-app and/or email) with a download link when it's ready, rather than blocking the UI.
- FR-5: Every export action is logged for audit purposes, capturing the admin user's id, the report name, applied filters, and a timestamp.

## User Experience / Flow

1. Admin is viewing a report table (with whatever filters/sort they've applied).
2. Admin clicks "Export CSV".
3. If under 5,000 rows: file downloads within ~3 seconds.
4. If over 5,000 rows: admin sees a "we'll notify you" confirmation, and later gets a link to download once the export job completes.
5. On error (e.g. export job fails), the admin is notified and can retry.

## High-Level Constraints

- Exported data must only include rows/columns the requesting admin already has permission to view in the UI — no privilege escalation via export.
- Export audit logs must be retained per the company's existing data-retention policy for internal tooling (assume whatever the project already does for similar audit logs).
- Must not degrade report table load times for the primary viewing experience.

## Out of Scope

- Scheduled or recurring exports.
- Export formats other than CSV (e.g. Excel, PDF).
- Exporting from customer-facing dashboards (this is admin-only).
- Building a general-purpose reporting/BI tool — this is scoped to exporting what's already shown in existing report tables.
