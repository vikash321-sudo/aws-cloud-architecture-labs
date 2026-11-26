# Architecture

```mermaid
flowchart LR
  U[Browser] -->|HTTP 8000| A
  U -->|HTTP 8000| B
  subgraph E[us-east-1 - development]
    A[EC2 Apache and PHP] --> D[(Local MariaDB)]
    A --> S[Secrets Manager via CafeRole]
  end
  A -. Private AMI and regional copy .-> B
  subgraph W[us-west-2 - production lab]
    B[EC2 Apache and PHP] --> R[(Local MariaDB copy)]
    B --> T[Regional Secrets Manager via CafeRole]
  end
```

Conceptual diagram of the demonstrated deployment. AMI copying is a one-time image transfer, not live replication. The two applications subsequently stored different orders independently.
