# Troubleshooting and verification

Run only on an authorized lab host. Set RDS_ENDPOINT locally to the actual private RDS DNS name. Enter passwords at prompts.

```bash
mysqldump --databases cafe_db -u root -p > CafeDbDump.sql
chmod 600 CafeDbDump.sql
ls -lh CafeDbDump.sql
tail -n 5 CafeDbDump.sql
nmap -Pn -p 3306 "$RDS_ENDPOINT"
# Import only to an empty intended destination
mysql -u admin -p --host "$RDS_ENDPOINT" < CafeDbDump.sql
echo $?
# Cutover verification
sudo systemctl stop mariadb
systemctl is-active mariadb
mysql -u admin -p --host "$RDS_ENDPOINT"
```

The actual Nmap scan used -Pn and reported 3306 open and 999 other scanned TCP ports filtered. Do not repeat an import after cutover without a recovery plan.

## Observed failures
- Initial IAM denial on RDS creation; later request succeeded, exact policy condition not established.
- Source export initially failed authentication; retry succeeded and completion footer verified.
- RDS login initially failed after cutover; subsequent login succeeded. SQL commands entered at Bash prompt failed, then retried inside MariaDB.
- Automated grader could not find its SSH identity file and reported public-key authentication failure repeatedly. It marked dump, connectivity and import checks as failed and reported local MariaDB running. Independent checks contradicted these reports. Exact rubric compliance remains unconfirmed.

Escalate grading discrepancy to course administrator with privately retained evidence. Do not modify grader files or weaken network security to recover marks.
