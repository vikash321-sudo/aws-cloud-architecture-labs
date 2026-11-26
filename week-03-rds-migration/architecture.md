# Database migration architecture

## Before
```mermaid
flowchart LR
  C[Browser] -->|HTTP 80| E
  subgraph V[Lab VPC - public subnet]
    E[EC2 Apache and PHP] --> L[(Local MariaDB)]
  end
```

## After
```mermaid
flowchart LR
  C[Browser] -->|HTTP 80| E
  subgraph V[Lab VPC]
    subgraph P[Public subnet]
      E[EC2 Apache and PHP - CafeSG]
      L[Local MariaDB stopped]
    end
    subgraph D[Private Subnet 1]
      R[(RDS MariaDB - dbSG)]
    end
    E -->|TCP 3306 from CafeSG| R
    L -. One-time SQL export and import .-> R
  end
  E -->|CafeRole| S[Secrets Manager]
```

Secrets Manager is a regional managed service shown outside the VPC boundary. Logical relationships are shown, not all route tables or availability-zone resources.
