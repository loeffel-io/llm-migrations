**Instructions:**

**1. Crucial Condition Check (Database vs. Stateless):**
Before writing any code, inspect the target service's filesystem.

- **IF the service HAS a database** (i.e., it contains an `internal/database/model` directory with GORM models): Apply the FULL transformation from the diff, including the Atlas/Goose migration setup (creating `db/` and `cmd/atlas/`).
- **IF the service DOES NOT have a database:** Completely IGNORE the GORM, Atlas, and Goose migration portions of the diff. Do not create database directories. ONLY apply the remaining structural changes, dependency bumps, and configuration updates.

**2. Mandatory OpenTelemetry Integration:**
The diff introduces OpenTelemetry tracing to the entry points (`main.go`). You must apply the exact same `otel` propagator setup, `otelgrpc` interceptors, and the updated `loggerFieldsFromContext` logic to the target service's `main.go` file(s).

**3. Map the Logic:**
Do not blindly copy the business logic or specific columns from the service. Translate the _mechanics_ of the migration and configs to fit the existing logic of the target service.

**4. Rule Override - Dependencies:**
_I explicitly approve adding and bumping the dependencies shown in the diff for this task._ You are authorized to bypass the "no new dependencies" rule in `agent.md` for this specific update. (Note: Only add the database dependencies if the service actually has a database).

**5. Bazel & Gazelle:**
Remember to use the `bazel run @rules_go//go -- mod tidy && bazel run //:gazelle && bazel mod tidy` command from `agent.md` to automatically update the `BUILD.bazel` files after you change the Go code.

**6. Validation (Only for services WITH a database):**
If the service has a database, when you are done:

- Run `bazel run //db:atlas_migration_sources`
- Ensure the `//db:atlas_migration_sources_test` test passes successfully.
- _Note: The `//db:atlas_migrations_test` will fail, and this is expected and okay. Do not try to fix it._

The diff is located at: DIFF_HERE
