# Troubleshooting

| Observation | Diagnostic action and outcome |
|---|---|
| Database login returned access denied | Rechecked credentials and subsequently established a MariaDB session. |
| AWS CLI reported NoCredentials after original instance profile was disassociated | Associated lab-provided CafeRole; STS and a Secrets Manager name query then succeeded. |
| AMI initially pending | Waited for source and destination AMIs to become available before launching. |
| Regional setup script reported association-ID argument error after creating secrets | Secret creation completed; subsequent destination application and order tests succeeded. The final script error was not independently resolved. |

Do not copy private SSH keys into reusable machine images. Credentials and raw metadata-token output are excluded.
