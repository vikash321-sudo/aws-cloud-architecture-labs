# AWS Cloud Architecture Labs

Hands-on AWS Academy coursework completed on 25 November 2026 as part of MSc Cyber Security studies. This portfolio documents implementation, testing and troubleshooting of educational cloud infrastructure, not an independent production deployment or official AWS reference solution.

| Workshop | Implementation | Evidence |
|---|---|---|
| [Week 2: Dynamic café website](week-02-dynamic-website/) | EC2, Apache, PHP, MariaDB, IAM, Secrets Manager, cross-region AMI deployment | Successful application and independent regional order histories |
| [Week 3: RDS migration](week-03-rds-migration/) | Private RDS, security group referencing, SQL migration and application cutover | 26 orders and 53 order items verified after cutover |

## Security engineering skills

- Role-based access to application secrets and temporary instance credentials.
- Network segmentation and restricted database ingress.
- Backup and restoration using native database tools.
- Application read/write validation and independent SSH troubleshooting.
- Distinguishing operational evidence from automated assessment results.

## Scope and responsible disclosure

These are educational sandbox deployments, not production-ready systems. Original AWS Academy instructions, application source, quiz answers, database dumps, private keys and credentials are not distributed. The optional Week 2 ECS exercise is not claimed as completed. Original screenshots are retained separately. See each workshop for limitations and recommended improvements.
