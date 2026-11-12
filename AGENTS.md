# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Application Platform: IBM Z

**Type:** IBM Enterprise COBOL for z/OS  
**Detected Languages:** IBM Enterprise COBOL for z/OS, PL/I, JCL, HLASM (IMS PSB/DBD), BMS, vanilla JavaScript  
**Full documentation:** https://ibm.github.io/Bank-of-Z/

## Architecture

Bank of Z is a hybrid banking app. Requests route to **CICS** (customer IDs starting with `C`) or **IMS TM** (IDs starting with `I`) via z/OS Connect as the REST gateway. A separate Liberty server (`FE<APP_SHORT_NAME>`, port 9445) serves the frontend WAR; z/OS Connect (`BAQ<APP_SHORT_NAME>`, port 9444) serves `/api`.

## Repository Layout

```
src/base/cics/        COBOL programs, BMS maps (.bms), copybooks (.cpy) for CICS
src/base/ims/         COBOL, PL/I, copybooks for IMS; PSB/ and DBD/ are HLASM assembled by IMS ACBGEN
src/base/batch/       Batch JCL and PL/I (BNKSTMT statement report)
src/api/              z/OS Connect API project (Gradle, produces api.war)
src/frontend/         Zero-dependency vanilla JS / static HTML frontend
.setup/               All provisioning and deployment automation — runs on z/OS USS
zcodescan/            ZCodeScan static analysis rule configuration
dbb-app.yaml          DBB application descriptor (single source of truth for build tasks)
.setup/build/         dbb-build.yaml + language config (Languages.yaml must be copied from DBB_HOME/samples)
.setup/config/config.yaml  Environment configuration (edit before running setup)
```

## Build System — IBM DBB (Dependency Based Build)

Builds run on z/OS USS via `$DBB_HOME/bin/dbb build`. There is no local compile step.

**Build lifecycles** (defined in `dbb-app.yaml` and `.setup/build/dbb-build.yaml`):

| Lifecycle | Purpose |
|-----------|---------|
| `user`    | Single-file user build from the IDE (triggers from Z Open Editor via `zapp.yaml`) |
| `file`    | Build one specific file from the CLI |
| `full`    | Build all programs (incl. frontend WAR, z/OS Connect, IMS Java) |
| `impact`  | Build only files impacted by changed sources |
| `pipeline`| Like impact, with packaging for Wazi Deploy |
| `merge`   | Build topic-branch changes before merging |

**User build command** (from `zapp.yaml` `zBuilder-userbuild` profile):
```bash
$DBB_HOME/bin/dbb build --hlq ${dbbHlq} \
  --config ${dbbWorkspace}/${dbbApplication}/dbb-app_ub.yaml \
  --errPrefix ${errPrefix} --verbose
```

## COBOL Compilation — Key Rules

- Default `compileParms`: `LIB` — suffix `CICS` auto-appended for CICS programs, `SQL` for embedded SQL.
- **`IBTRAN.cbl`** is special: compiled with `LP(32),JAVAIOP(JAVA64),DLL,RENT,PGMNAME(LONGMIXED)` for the IMS→Java bridge. Link-edit includes `igzxjni2.x` and `libjvm31.x`.
- IMS batch COBOL programs link against `CBLTDLI` and require `ENTRY DLITCBL` in the link-edit stream.
- Copybook search path: `${WORKSPACE}/?path=${APP_DIR_NAME}/src/base/**/*.cpy`
- Deploy targets: `CICSLOAD` (CICS programs), `IMSLOAD` (IMS programs), `LOAD` (batch)

## PL/I Compilation

- `IBLOGIN.pli` (IMS TM) requires `DFSLI000` and `ENTRY CEESTART` in link-edit.
- Batch PL/I (`src/base/batch/pli/`) links with `ENTRY CEESTART`, DB2 via DSN RUN in JCL.

## Assembler (IMS PSB / DBD)

- PSBs (`src/base/ims/PSB/*.asm`) deploy as `PSBLOAD`; DBDs (`src/base/ims/DBD/*.asm`) as `DBDLOAD`.
- These are assembled by IMS ACBGEN, not a normal compile/link.

## Setup and Deployment

- Environment config: `.setup/config/config.yaml` (must be edited for target system).
- Long-running steps **always time out** over MCP. Use the three helper scripts in `.setup/mcp-helpers/` — `bankz-launch.sh`, `bankz-poll.sh`, `bankz-scan.sh` — as documented in the `deploy-uss` skill.
- Setup stages: `validate-prereqs` → `environment` → `install-bank-of-z` via `setup-common.sh`.

## Static Analysis (ZCodeScan)

Rules config: `zcodescan/zcodescan-rules.yaml`. Notable enforced rules:
- `CheckSqlcodeAfterExecSqlRule` (HIGH) — always check SQLCODE after EXEC SQL
- `SqlAvoidSelectStarRule` (HIGH) — no `SELECT *`
- `FileStatusCheckRule` (HIGH) — always check file status
- `OccursDependingOnRule` (HIGH) — flag unsafe OCCURS DEPENDING ON
- `InlinePerformLineLimitRule` — inline PERFORM max 30 lines
- `ProcedureRule` — procedure max 100 lines
- `NestedIfLimitRule` — max 6 levels of nested IF
- ZCodeScan max RC is 4 (warnings do not fail the build)

## Testing

`tests/test_get_customer.sh` is an integration test — requires a live deployed environment at the configured `BASE_URL`. There are no offline/unit tests; use IBM TAZ (unit testing profile `taz-test` in `zapp.yaml`) for isolated COBOL unit tests.

## Git Commit Rule (MANDATORY)

**All commits MUST be signed off** (`git commit -s -m "message"`). DCO checks are enforced on PRs. Use `git commit --amend -s --no-edit` to fix the last commit if you forgot.

## Data Dictionary Location

The data dictionary for this project is located at:

- `/Users/dennisbehm/git/webinar/Bank-of-Z/bobz/DD.json`

This file contains variable descriptions and business context for COBOL or PL/I programs.
Always reference this file when analyzing or modifying COBOL or PL/I code.

## Technical Documentation

Full docs: `docs/docs/` (also published at https://ibm.github.io/Bank-of-Z/)

| COBOL Program(s) | Documentation | Purpose |
|---|---|---|
| BNKMENU | `docs/docs/architecture/application-components.md`, `docs/docs/architecture/application-flow.md` | Main menu; CICS entry point |
| BNK1CAC, BNK1CCA, BNK1CCS, CREACC, CRECUST | `docs/docs/architecture/application-components.md` | Account/customer creation (CICS) |
| BNK1DAC, BNK1DCS, DELACC, DELCUS | `docs/docs/architecture/application-components.md` | Account/customer deletion (CICS) |
| BNK1UAC, UPDACC, UPDCUST | `docs/docs/architecture/application-components.md` | Account/customer updates (CICS) |
| BNK1TFN, XFRFUN, DBCRFUN | `docs/docs/architecture/application-components.md` | Fund transfers and debit/credit (CICS) |
| INQACC, INQCUST, INQACCCU, INQTRANL, INQTRAND | `docs/docs/architecture/application-components.md` | Inquiry programs (CICS + z/OS Connect) |
| CRDTAGY1–5, ABNDPROC | `docs/docs/architecture/application-components.md` | Credit agency / abend handling (CICS) |
| IBLOGIN1, IBLOGOUT, IBTRAN, IBSCUDAT, IBGCUDAT, IBACSUM | `docs/docs/architecture/application-components.md` | IMS TM transaction programs |
| LOADxxxx (LOADACCT, LOADCUST, etc.) | `docs/docs/architecture/build-and-deployment.md` | IMS database load utilities |
| BNKSTMT | `docs/docs/architecture/application-components.md` | Batch statement PL/I program |

**Auto-update rule:** When a COBOL or PL/I program is modified, check if related documentation exists in the table above and prompt for a documentation update if the change is functionally significant.

## Frontend Notes

- Zero-dependency static HTML — no build step, no npm, no bundler.
- Carbon Web Components loaded from IBM CDN (`https://1.www.s81c.com/common/carbon/web-components/version/v2.47.0/`). Each HTML page imports only the components it uses.
- API base URL constructed dynamically in `config.js` using `window.location.protocol` and `hostname` pointing at port 9444 (z/OS Connect HTTPS).
- Customer ID routing is done in the frontend: prefix `C` → CICS path, prefix `I` → IMS path.
