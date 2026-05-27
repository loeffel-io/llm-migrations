We added ctx to status errors to support better debugging.
The `migration.sh` file does most of the work but there are still some parts that need to be done manually.
The `global-generics@v0.36.0` added the breaking change.
The `internal/envoy/service/auth/auth_v3/external_auth.go` file is the only one that needs to be updated manually and
also the indication if the migration is needed or not.
