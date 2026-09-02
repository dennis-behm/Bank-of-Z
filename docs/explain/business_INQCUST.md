# INQCUST — Customer Inquiry Service

## Business Purpose Summary

**INQCUST** is a **mission-critical CICS service program** in the banking domain that acts as the authoritative customer record retrieval component. Its sole responsibility is to look up a bank customer's complete profile — including personal details, contact information, address, credit score, and account status — and return that information to any calling program via a communication area (COMMAREA).

The program serves as the **single point of truth for customer data access** within the Bank-of-Z core banking system. It is invoked by other programs (such as `INQACCCU`) rather than directly by end users, making it a **back-end service component** in the customer inquiry transaction chain.

### Key Business Capabilities

| Capability | Description |
|---|---|
| **Direct Customer Lookup** | Retrieves a specific customer by customer number and bank sort code |
| **Random Customer Selection** | When called with customer number `0000000000`, randomly selects any valid customer on file — useful for demos, testing, and data browsing |
| **Latest Customer Retrieval** | When called with customer number `9999999999`, returns the most recently registered customer in the bank's database |
| **Not-Found Handling** | Gracefully signals when a requested customer does not exist, returning a blank record with a failure indicator (`INQCUST-INQ-FAIL-CD = '1'`) instead of crashing |
| **Infrastructure Resilience** | Handles VSAM RLS database abends (`AFCR`, `AFCS`, `AFCT`) through a CPSM WLM "Storm Drain" pattern — rolling back changes and returning a controlled failure (`INQCUST-INQ-FAIL-CD = '2'`) rather than allowing a hard crash |
| **DB2 Error Escalation** | On unexpected database errors, assembles a full diagnostic record (abend code `CVR1`, task number, transaction ID, timestamp, SQLCODE) and links to a central abend handler program (`ABNDPROC`) before terminating |

### Business Domain

This program operates in the **retail banking** domain — specifically within the **customer master data** subdomain. It underpins any business process that needs to verify a customer's identity, creditworthiness (`CUSTOMER-CREDIT-SCORE`), or contact details before proceeding (e.g. account inquiry, loan processing, customer service lookups).

### Criticality

**Mission-critical.** Without a functioning customer inquiry service, downstream banking transactions — account inquiries, fund transfers, customer service operations — cannot verify the identity or status of the customer they are acting on behalf of. The program's robust error handling (retry logic, storm drain support, structured abend reporting) reflects this high-availability requirement.

---

## Program Flow

```mermaid
flowchart TD
    A([Start: Receive Customer Inquiry Request]) --> B[Set up CICS Abend Handler\nInitialise success flag to N\nInitialise failure code to 0]
    B --> C{Sort code provided\nin request?}
    C -- No --> D[Use system default\nSort Code]
    C -- Yes --> E[Use provided Sort Code]
    D --> F[Copy customer number\nfrom request]
    E --> F

    F --> G{Customer number\nis 0 or all-9s?}

    G -- Yes --> H[Query DB2 for\nhighest customer number\nORDER BY DESC FETCH 1 ROW]
    H --> H1{DB2 query\nsuccessful?}
    H1 -- No --> EXIT_FAIL([Return failure\nto caller])
    H1 -- Yes --> I[Store highest\ncustomer number]
    I --> J{Customer number\nis exactly 0?}
    J -- Yes --> K[Generate random\ncustomer number\nusing CICS task seed]
    J -- No --> L[Use highest\ncustomer number directly]
    K --> L

    G -- No --> M[Use customer number\nas provided]

    L --> N
    M --> N[Execute DB2 SELECT\non CUSTOMER table\nby sort code + customer number]

    N --> O{DB2 SQLCODE?}

    O -- SQLCODE = 0\nRecord found --> P[Map all customer fields\nfrom DB2 host variables\nto output area\nDecompose date fields]
    P --> Q[Set success flag to Y\nPopulate COMMAREA\nwith full customer profile]
    Q --> R([Return successfully\nto calling program])

    O -- SQLCODE = 100\nNot found - random request --> S{Retry count\nunder 1000?}
    S -- Yes --> T[Generate new\nrandom customer number\nIncrement retry counter]
    T --> N
    S -- No --> U[Set failure code 1\nCustomer not found]
    U --> EXIT_FAIL

    O -- SQLCODE = 100\nNot found - all-9s request --> V{Already\nretried?}
    V -- No --> W[Re-query DB2 for\nhighest customer number\nMark as retried]
    W --> N
    V -- Yes --> X[Clear customer fields\nSet failure code 1]
    X --> EXIT_FAIL

    O -- SQLCODE = 100\nNot found - direct lookup --> X

    O -- Other SQLCODE\nDB2 error --> Y[Build diagnostic record\nCapture APPLID, task no,\ntransaction ID, timestamp, SQLCODE]
    Y --> Z[Link to Abend Handler\nprogram ABNDPROC]
    Z --> AA([Issue CICS ABEND CVR1\nTerminate task abnormally])

    B -.->|Abend intercepted| AB{Abend code\ntype?}
    AB -- AFCR / AFCS / AFCT\nVSAM RLS abend --> AC[Set Storm Drain flag\nIssue SYNCPOINT ROLLBACK]
    AC --> AD{Rollback\nsuccessful?}
    AD -- Yes --> AE[Set failure code 2\nReturn controlled failure]
    AE --> EXIT_FAIL
    AD -- No --> AF[Build rollback failure\ndiagnostic record]
    AF --> AG([Issue CICS ABEND HROL\nTerminate task abnormally])

    AB -- Other abend --> AH([Re-issue original\nabend code\nTerminate task])
```

---

Generated by IBM Bob Premium Package for Z
