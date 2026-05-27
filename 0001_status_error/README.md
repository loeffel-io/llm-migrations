We added ctx to status errors to support better debugging.
The `migration.sh` file does most of the work but there are still some parts that need to be done manually.
I am not sure anymore which version of global generics introduced the breaking change.
The `internal/envoy/service/auth/auth_v3/external_auth.go` file is the only one that needs to be updated manually and
also the indication if the migration is needed or not.
