# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Workspace Type

**Application platform:** IBM Z  
**Type:** Hybrid IBM Z banking application (Bank of Z)  
**Detected Languages:** IBM Enterprise COBOL for z/OS, PL/I, Assembler (HLASM), BMS, JCL, Java (IMS bridge), z/OS Connect (OpenAPI/Gradle), JavaScript/HTML

## Source Layout

| Path | Contents |
|------|----------|
| `src/base/cics/cobol/` | CICS COBOL programs |
| `src/base/cics/bms/` | BMS map definitions |
| `src/base/cics/copy/` | CICS copybooks |
| `src/base/ims/cobol/` | IMS COBOL programs |
| `src/base/ims/pli/` | IMS PL/I programs |
| `src/base/ims/PSB/` | IMS PSB control blocks (Assembler) |
| `src/base/ims/DBD/` | IMS DBD database definitions (Assembler) |
| `src/base/ims/java/` | IMS Java bridge (Gradle project) |
| `src/base/batch/pli/` | Batch PL/I programs |
| `src/base/batch/jcl/` | Batch JCL |
| `src/api/` | z/OS Connect API (OpenAPI + Gradle) — produces the deployable API artifact |
| `src/frontend/` | Browser-based UI (vanilla HTML/CSS/JS) |
| `.setup/` | All z/OS USS setup and pipeline automation |
| `zcodescan/zcodescan-rules.yaml` | Custom ZCodeScan static analysis rules (COBOL + PL/I) |

## Critical Routing Logic

Customer ID prefix determines the backend transaction path — this is enforced in the frontend (`src/frontend/js/`) before hitting the API:
- `Cnnnn` → CICS (`/api/customers/`)
- `Innn` → IMS (`/api/ims/customers/`)

## Build System

IBM DBB (`dbb-app.yaml`) handles all mainframe compilation. Key non-obvious build rules:

- **COBOL compiler parms are dynamic:** Base is `LIB`; `CICS` is appended when `IS_CICS` is detected, `SQL` when `IS_SQL` is detected. Do not hard-code compiler options in source.
- **`IBTRAN.cbl` uses special flags:** `LP(32),JAVAIOP(JAVA64),DLL,RENT,PGMNAME(LONGMIXED)` — this is the 31-bit COBOL to 64-bit Java bridge for IMS. Link-edit includes `igzxjni2.x` and `libjvm31.x`.
- **IMS batch COBOL programs** (IBACSUM, IBGCUDAT, IBLOGIN1, IBLOGOUT, IBSCUDAT, LOAD*) require `ENTRY DLITCBL` in the link-edit stream with `CBLTDLI` — they cannot be link-edited like regular COBOL.
- **IMS PL/I programs** use `ENTRY CEESTART` in link-edit; `IBLOGIN.pli` also needs `INCLUDE RESLIB(DFSLI000)`.
- **Assembler sources in `PSB/`** deploy as `PSBLOAD`; in `DBD/` deploy as `DBDLOAD` — not standard `LOAD`.
- **`**/LoadData/**` is excluded** from all DBB scan and build steps.
- **User build profile:** `zBuilder-userbuild` (defined in `zapp.yaml`). Default HLQ: `IBMUSER.BOZ.UB`, USS workspace: `/u/ibmuser/userBuild_boz`.

## Development Workflows

Two workflows — choose based on need:
- **Zowe CLI workflow:** Branch-based, requires commit before testing. Triggered via VS Code task `Setup Bank of Z Environment` or `bash ./.setup/setup-local.sh`.
- **GRUB workflow:** No commit required; syncs local files directly to USS via SSH. Triggered by `bash ./.setup/pipeline-common.sh` (configured in `grub.buildCommand` in `.vscode/settings.json`).

Incremental pipeline (rebuild + redeploy only changed files): `bash ./.setup/pipeline-remote.sh` (runs on USS).

## Testing

Integration tests are bash scripts in `tests/test_*.sh`. They require a running Bank of Z deployment.

Run all tests:
```bash
BASE_URL=http://<host>:9080/api FRONTEND_URL=http://<host>:9081 bash tests/run-all.sh
```

Run a single test (example):
```bash
BASE_URL=http://<host>:9080/api FRONTEND_URL=http://<host>:9081 bash tests/test_get_customer_cics.sh
```

Set `IMS_DISABLED=true` to skip IMS tests when IMS is not deployed.

Port defaults come from `.setup/config/config.yaml` (z/OS Connect HTTP: `9080`, HTTPS: `9444`; Frontend HTTP: `9081`, HTTPS: `9445`).

## Git Requirements

**ALL commits must include `-s` (DCO sign-off):**
```bash
git commit -s -m "your message"
```
PRs with unsigned commits are automatically rejected. To fix unsigned commits:
```bash
git commit --amend -s --no-edit          # last commit
git rebase HEAD~N --signoff              # N previous commits
```

A `detect-secrets` pre-commit hook is active (`--fail-on-unaudited`). Run `git add .` then commit; unaudited secrets will block the commit.

## z/OS Connect API

The API project (`src/api/`) is Gradle-based using the `com.ibm.zosconnect.gradle` plugin. The OpenAPI spec is at `src/api/src/main/api/openapi.yaml`. Generated provider files (`.cpy`) live under `src/api/src/main/zosAssets/<PROGRAM>/providerFiles/gen/` — do not manually edit generated `*_request_0.cpy` / `*_response_0.cpy` files.

## ZCodeScan Rules

Custom static analysis rules are in `zcodescan/zcodescan-rules.yaml`. The `zcodescan` profile in `zapp.yaml` points to this file. Notable project-specific rules:
- `ConditionNamePrefixRule`: condition names must start with `TEST`
- `FileNameConventionRule`: file name mask `SAM.*`
- `ProcedureRule`: paragraph line limit is 100
- `InlinePerformLineLimitRule`: inline PERFORM limit is 30 lines
- `NestedIfLimitRule`: max nesting depth is 6

## Technical Documentation Mapping

Full documentation is at **https://ibm.github.io/Bank-of-Z/** (source in `docs/`).

| Program / Component | Documentation |
|---------------------|---------------|
| CICS COBOL programs (`src/base/cics/cobol/`) | `docs/docs/architecture/application-components.md`, `docs/docs/architecture/application-flow.md` |
| IMS COBOL / PL/I programs (`src/base/ims/`) | `docs/docs/architecture/application-components.md`, `docs/docs/architecture/application-flow.md` |
| CICS enhancement / debugging | `docs/docs/tutorials/cics-enhancement-scenario.md`, `docs/docs/tutorials/debug-cics-transaction.md` |
| Build & deployment | `docs/docs/architecture/build-and-deployment.md`, `docs/docs/tutorials/incremental-build.md` |
| Zowe CLI workflow | `docs/docs/development-workflows/zowe-cli-workflow.md` |
| GRUB workflow | `docs/docs/development-workflows/grub-workflow.md` |
| Configuration reference | `docs/docs/reference/configuration-reference.md` |
| Repository structure | `docs/docs/reference/repository-structure.md` |

**Auto-update rule:** When a COBOL or PL/I program is modified, check whether the mapped documentation above reflects the change. If the logic or interface changes, update the corresponding `docs/docs/` file and note it in the commit.

## Data Dictionary Location

The data dictionary for this project is located at:

- `bobz/DD.json`

This file contains variable descriptions and business context for COBOL and PL/I programs in the Bank of Z application. Always reference this file when analyzing or modifying COBOL or PL/I code. It was generated by scanning programs under `src/base/` and covers key business variables across CICS, IMS, and batch components.

