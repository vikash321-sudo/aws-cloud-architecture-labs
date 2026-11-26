# Week 2 — Deploying a dynamic café website across AWS regions

## Objective
Deploy a PHP café application backed by MariaDB on EC2 and reproduce the development environment in a second region using an Amazon Machine Image (AMI).

## Implementation
1. Inspected the supplied Amazon Linux EC2 instance, public subnet, IAM role and security group.
2. Configured Apache on TCP 8000 alongside the lab IDE, started MariaDB and validated a simple HTML page using curl.
3. Installed the supplied café application and initialized the database. Verified nine menu products with SQL.
4. Configured application parameters in AWS Secrets Manager and associated CafeRole. Confirmed that the instance could retrieve the named secret without printing its value.
5. Validated the development application in N. Virginia (us-east-1) with an order for two croissants and one coffee, total $6.00.
6. Created the private CafeServer AMI, waited for availability, copied it to Oregon (us-west-2) and launched ProdCafeServer from the copied image with CafeRole and a t2.small instance type.
7. Created regional application secrets using the supplied setup script and destination DNS name. Validated the destination application with an order for two hot chocolates, total $6.00.
8. Compared regional order histories. Both inherited the original order, but subsequent order #2 differed, demonstrating independent database state.

## Validation
| Test | Result |
|---|---|
| Development application and order submission | Passed |
| Private source AMI and regional copy | Available |
| Destination EC2 launch | Running |
| Destination application and order submission | Passed |
| Independent regional histories | Observed |

The embedded lab grader displayed 30/30; Canvas showed 24/30 in the same screenshot. This discrepancy was not independently resolved.

## Security reflection
IAM roles and Secrets Manager avoid hardcoding AWS credentials. AMIs capture disk state, not a continuously synchronized database. The lab used HTTP and public web access; production should use HTTPS, restricted administration, separate database infrastructure and sanitized images without embedded private keys or sensitive data. No production hardening is claimed.

- [Architecture](architecture.md)
- [Troubleshooting](troubleshooting.md)
- [Evidence index](evidence/README.md)
