# Week 3 — Migrating a self-managed MariaDB database to Amazon RDS

## Objective
Separate the café application from its local database, preserve historical orders and verify new writes to a private managed database.

## Environment
A fresh AWS Academy sandbox in us-east-1 supplied an Amazon Linux 2023 CafeServer (t2.micro) running the application and local MariaDB 10.11.19. The destination RDS instance was MariaDB 10.6.25, db.t3.micro, in us-east-1a, with no public IPv4 address. The lab VPC contained a public application subnet and private database subnets.

## Implementation
1. Created RDS and confirmed Available status. An initial CreateDBInstance permission denial preceded successful deployment.
2. Placed a pre-migration test order (#25: four hot chocolates, $12). Verified 25 orders and 52 order-item rows locally.
3. Exported cafe_db using mysqldump. Checked completion footer and file size (7,756 bytes); restricted dump to mode 600.
4. Configured database ingress on TCP 3306 from the café application security group only. Verified connectivity from EC2 using the MariaDB client and Nmap.
5. Imported the dump into RDS. Shell exit status was 0. Confirmed four tables (order, order_item, product, product_group) and baseline counts.
6. Updated existing Secrets Manager endpoint, username and password entries to target RDS without publishing credentials.
7. Stopped local MariaDB and verified historical orders remained accessible.
8. Submitted order #26 (two croissants, $3.00), then queried RDS to confirm the new order and updated counts.

## Results
| Metric | Source | RDS after import | RDS after cutover |
|---|---:|---:|---:|
| Orders | 25 | 25 | 26 |
| Order items | 52 | 52 | 53 |
| Order #25 | $12.00 | $12.00 | Preserved |
| Order #26 | Not present | Not present | $3.00 |

Local MariaDB was inactive during the new-order test. Matching counts and selected order are evidence of migration and application writes, not an exhaustive row-by-row integrity audit.

## Assessment discrepancy
Official score: 11/25. Repeated grader logs reported a missing SSH private key on the grading host and public-key authentication failure. Independent SSH from Windows succeeded; dump existed, SSH service was active and local MariaDB inactive. This strongly suggests grading infrastructure failure; additional exact lab settings could still affect marks. No corrected grade is claimed.

## Security reflection
Private RDS networking, source-security-group references and centralized secrets reduce exposure. The lab used public HTTP and broadly accessible SSH on the application server. Production improvements include HTTPS, Session Manager instead of public SSH, least-privilege application DB user instead of master account, TLS verification, backup/restore testing and controlled write freeze or replication during cutover. These are recommendations, not implemented features.

- [Architecture](architecture.md)
- [Troubleshooting](troubleshooting.md)
- [Read-only validation queries](validation.sql)
- [Evidence index](evidence/README.md)
