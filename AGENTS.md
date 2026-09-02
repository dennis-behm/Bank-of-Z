# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Application Platform: IBM Z

**Type:** Hybrid IBM Z banking application  
**Detected Languages:** IBM Enterprise COBOL for z/OS, PL/I, JCL, Assembler (IMS PSB/DBD), BMS  
**Build System:** IBM Dependency Based Build (DBB) via `dbb-app.yaml`  
**Application Name:** BANKZ

## Source Layout

All mainframe source lives under `src/base/`. The layout is non-obvious:

| Path | Contents |
|------|----------|
| `src/base/cics/cobol/` | CICS COBOL programs |
| `src/base/cics/copy/` | Copybooks (`.cpy`) shared by CICS programs |
| `src/base/cics/bms/` | BMS map sources |
| `src/base/ims/cobol/` | IMS COBOL programs |
| `src/base/ims/copy/` | Copybooks for IMS programs |
| `src/base/ims/pli/` | IMS PL/I programs |
| `src/base/ims/PSB/` | IMS Program Specification Blocks (Assembler, deployed to `PSBLOAD`) |
| `src/base/ims/DBD/` | IMS Database Descriptors (Assembler, deployed to `DBDLOAD`) |
| `src/base/batch/jcl/` | Batch JCL |
| `src/base/batch/pli/` | Batch PL/I programs |
| `src/api/` | z/OS Connect API project (Gradle-based, produces the API WAR) |
| `src/frontend/` | Browser frontend (vanilla HTML/JS/CSS, deployed as a WAR to a *separate* Liberty server) |

## Routing Logic (Critical Architecture Detail)

Requests are routed by the **UI** (not by z/OS Connect) based on the customer ID prefix:

- Customer IDs starting with **`C`** → CICS transaction path
- Customer IDs starting with **`I`** → IMS TM transaction path

The frontend strips the prefix before sending to the API (e.g., `C0000001` → `0000001`).

## Build — DBB (`dbb-app.yaml`)

- The build glob for COBOL is `**/src/base/**/cobol/*.cbl`; only files under a `cobol/` folder are compiled.
- `compileParms` are conditionally appended: `CICS` is added if `${IS_CICS}` is set; `SQL` if `${IS_SQL}`.
- **`IBTRAN.cbl`** has unique compile/link settings: `LP(32),JAVAIOP(JAVA64),DLL,RENT,PGMNAME(LONGMIXED)` — required for the IMS Java (31-bit → 64-bit) bridge.
- IMS batch COBOL programs require a custom link-edit instream that includes `DFSLI000` and sets `ENTRY DLITCBL`.
- IMS PL/I programs under `ims/pli/` need `isIMS: true`; IMS PL/I link requires `CEESTART` entry point and `DFSLI000`.
- PSB/DBD Assembler sources (`ims/PSB/*.asm`, `ims/DBD/*.asm`) deploy to `PSBLOAD`/`DBDLOAD` respectively — not `LOAD`.
- User build profile in `zapp.yaml`: `zBuilder-userbuild`. Copybooks are searched in `src/base/**/*.cpy`.

## Configuration

- All environment settings live in `.setup/config/config.yaml` (Jinja2 template syntax with `{{ }}` references).
- The Zowe profile used by default is `bankofz.zosmf` (see `.vscode/settings.json`).
- Personal settings that vary per developer are in `.vscode/settings.json` (e.g., `dbbHlq`, `dbbWorkspace`).
- Copy `.zdx.json.template` to `.zdx.json` and fill in `?` placeholders for debug listing access.

## Testing

Integration tests are bash scripts in `tests/`. They hit the live z/OS Connect API; they are **not** unit tests.

- **Run all tests:** `tests/run-all.sh`
- **Run a single test:** `bash tests/test_get_customer_cics.sh` (set `BASE_URL` env var first, or configure `.setup/config/config.yaml`)
- Tests source `tests/test-setup.sh` for URL resolution; ports come from `ZOSCONNECT_HTTP_PORT` / `FRONTEND_HTTP_PORT`.
- To skip IMS tests: `IMS_DISABLED=true bash tests/run-all.sh`

## Static Analysis — ZCodeScan

Custom rules are in `zcodescan/zcodescan-rules.yaml` and referenced from `zapp.yaml` profile `zcodescan`.  
Notable non-default rules active in this project:
- `ConditionNamePrefixRule` — condition names must start with prefix `TEST`
- `FileNameConventionRule` — file name mask `SAM.*`
- `InlinePerformLineLimitRule` — max 30 lines per inline PERFORM
- `NestedIfLimitRule` — max 6 nesting levels
- `ProcedureRule` — max 100 lines per paragraph/procedure

## Git Commit Requirements (MANDATORY)

Every commit **must** be signed-off with `-s`:

```bash
git commit -s -m "Your message"
```

Pull requests with unsigned commits are rejected by the DCO check. To fix unsigned commits:
```bash
git commit --amend -s --no-edit        # last commit
git rebase HEAD~N --signoff            # N previous commits
```

## COBOL Code Style (from source inspection)

- COBOL programs start with `CBL CICS(...)` and/or `CBL SQL` compiler directives on line 1.
- DB2 table definitions are included via `EXEC SQL INCLUDE <copybook> END-EXEC` (not `COPY`).
- Copybooks for DB2 host variables follow the naming pattern `*DB2.cpy` (e.g., `CUSTDB2.cpy`).
- Programs abend on error rather than returning error codes — abend handling is centralised in `ABNDPROC.cbl`.

## Documentation Mapping

| Program / Source | Documentation |
|-----------------|---------------|
| `src/base/cics/cobol/*.cbl` | `docs/docs/architecture/application-components.md`, `docs/docs/architecture/application-flow.md` |
| `src/base/ims/cobol/*.cbl`, `src/base/ims/pli/*.pli` | `docs/docs/architecture/application-components.md`, `docs/docs/architecture/application-flow.md` |
| `src/base/ims/PSB/*.asm`, `src/base/ims/DBD/*.asm` | `docs/docs/architecture/application-components.md` |
| `src/api/` | `docs/docs/architecture/application-components.md` |
| `src/frontend/` | `docs/docs/architecture/application-flow.md` |
| Repository setup / deployment | `docs/docs/reference/repository-structure.md`, `docs/docs/installation-and-setup/` |

**Auto-Update Rules:**
1. When modifying COBOL, PL/I, or BMS sources, check if the related documentation above is still accurate.
2. When adding new programs, update this mapping table.
3. When analyzing a program, reference its mapped documentation for architectural context.
