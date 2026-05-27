**Requires 0001 + Agents.md file + MySQL or stateless service (sqlite not supported)**

Before mindful can go live we need to move from gorm to atlas migrations.
Atlas does generate the migrations.
We use a llm generated python script to split the initial sql file initial
one ddl per sql file to make mysql happy (mysql 8 does not support multiple ddls per transaction).

Process:

- **1. Apply patch:**
  Let llm apply the patch including the llm.md introduction and instructions.
- **2. Run the sql script:**
  Run the python script to split the initial sql file into multiple files.
- **3. Run atlas:**
  Run `atlas migrate hash` to generate the new `atlas.sum` file.
- **4. Make sure bazel is happy:**
  Run `bazel build //...` to make sure bazel is happy with the new files.
- **5. Dump the database:**
  Dump the mysql database
- **6. Delete all tables:**
  Delete all tables from the database.
- **7. Deploy the new code:**
  Deploy the new code with the atlas migrations.
- **8. Import the dumped data:**
  Import the dumped data back into the database.
- **9. Cleanup:**
  Remove `allow_empty = True` from `atlas_migrations_mysql` target
