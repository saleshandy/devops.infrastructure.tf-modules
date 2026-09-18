*Example*

```
module "example_dms_source" {
  source        = "github.com/saleshandy/devops.infrastructure.tf-modules/provider/aws/dms_endpoint/v1"
  name          = "example-source"
  endpoint_type = "source"
  engine_name   = "aurora"

  server_name   = "example-cluster.cluster-abc123.us-west-2.rds.amazonaws.com"
  port          = 3306
  database_name = "app_db"
  username      = "dms_user"
  password      = var.dms_source_password
  ssl_mode      = "none"
}
```

Notes

- `engine_name` is `aurora` for Aurora MySQL and `aurora-postgresql` for Aurora PostgreSQL, not `mysql` or `postgres` — those are for self-managed or plain RDS instances.
- Use the **cluster writer endpoint** as `server_name`, not an instance endpoint, so the connection follows a failover.
- **`ssl_mode` is not just hygiene on MySQL 8.4 targets.** That version only ships `caching_sha2_password`, which refuses to send a password over an unencrypted socket unless the client fetches the server's RSA public key first. `require` encrypts the connection without needing a CA bundle or client certificates, and sidesteps the question entirely. `verify-full` additionally validates the certificate and needs the RDS CA.
- Passwords are stored in Terraform state. Feed them from a variable held outside version control rather than writing them into the configuration.
- The endpoint is only a stored connection — creating it proves nothing. Run `aws dms test-connection --replication-instance-arn ... --endpoint-arn ...` and then `describe-connections`, which is what actually exercises the network path, the security groups and the credentials together.
- A test connection needs a replication instance, so endpoints cannot be validated before one exists.
