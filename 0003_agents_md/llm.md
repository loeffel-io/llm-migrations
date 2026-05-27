**Instructions:**

**1. Map the Logic:**
Apply the attachted patch please in a consistent way.
Do not blindly copy the business logic or specific columns from the service. Translate the _mechanics_ configs to fit the existing logic of the target service.

**2. Rule Override - Dependencies:**
_I explicitly approve adding and bumping the dependencies shown in the diff for this task._ You are authorized to bypass the "no new dependencies" rule in `agent.md` for this specific update.

**3. Bazel & Gazelle:**
Remember to use the `bazel mod tidy` command from `agent.md` to automatically update the `BUILD.bazel` files after you change the bazel code.

**6. Validation:**
when you are done:

- Run `bazel run //:agents_md_source`
- Ensure the `//:agents_md_source_test` test passes successfully.
