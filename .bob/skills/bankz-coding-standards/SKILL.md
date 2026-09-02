---
name: bankz-coding-standards
description: Enforces BANKZ coding standards for COBOL, PL/I, JCL, and Assembler. Discovered from codebase analysis. Use when "review code", "check standards", "generate code", "refactor code", "BANKZ conventions", or "style guide".
metadata:
  author: Discovered by Bob Z Coding Standards Builder
  version: 1.0.0
  enforcement-level: moderate
  target-languages: COBOL, PL/I, JCL, Assembler (PSB/DBD)
  discovery-date: 2025-07-14
  files-analyzed: 30
  confidence-threshold: 80%
---

# BANKZ Coding Standards

Enforces coding standards and best practices for the BANKZ hybrid IBM Z banking application. Standards discovered by analyzing the actual codebase across CICS, IMS, DB2, PL/I, JCL, and Assembler sources.

## Instructions

### When to Apply This Skill

Use this skill when:
- Generating new COBOL, PL/I, JCL, or Assembler code for BANKZ
- Reviewing existing BANKZ source files
- Refactoring or modernising BANKZ programs
- Conducting code reviews before merging
- Onboarding new developers to the BANKZ codebase

---

### Step 1: Identify Language, Subsystem, and Context

Before applying standards, determine:
1. **Language**: COBOL, PL/I, JCL, or Assembler (PSB/DBD)
2. **Subsystem** (for COBOL): CICS, IMS/DL-I, or Batch
3. **New code or modification**: New code must follow all standards; modifications should conform to surrounding code while correcting violations opportunistically
4. **DB2 involvement**: DB2 programs have additional host variable and SQL standards

---

### Step 2: Apply File-Level Standards

#### 2.1 Compiler Directives (Line 1) — MUST follow

Every COBOL source file MUST begin with the appropriate compiler directive:

**CICS COBOL programs:**
```cobol
       PROCESS CICS,NODYNAM,NSYMBOL(NATIONAL),TRUNC(STD)
       CBL CICS('SP,EDF')
       CBL SQL
```
Or for non-SQL CICS programs:
```cobol
       PROCESS CICS,NODYNAM,NSYMBOL(NATIONAL),TRUNC(STD)
       CBL CICS('SP,EDF')
```
DLI-capable CICS programs add `DLI` to the CBL CICS options:
```cobol
       CBL CICS('SP,EDF,DLI')
```

**IMS COBOL programs:**
```cobol
       CBL LIST,MAP,XREF,FLAG(I)
```

**IMS PL/I programs:**
```pli
*PROCESS SYSTEM(IMS);
```

#### 2.2 Copyright Header Block — MUST follow

All COBOL programs MUST start with the IBM copyright box immediately after the compiler directive:
```cobol
      ******************************************************************
      *                                                                *
      *  Copyright IBM Corp. 2023                                      *
      *                                                                *
      ******************************************************************
```
Followed by a **free-form description block** (prose, not keyword headers):
```cobol
      ******************************************************************
      * This program takes customer number as input
      * and returns to the calling program a commarea containing all
      * of the customer information for that record.
      *
      * If there is any kind of problem then an appropriate abend is
      * issued.
      ******************************************************************
```

PL/I programs use box comments:
```pli
  /*------------------------------------------------------------*
   * Licensed Materials - Property of IBM
   *
   * (c) Copyright IBM Corp. 2026.
   *------------------------------------------------------------*/

  /*------------------------------------------------------------*
  * Procedure: BNKSTMT
  * Description: PL/I Batch Program for Bank Monthly Statement
  *------------------------------------------------------------*/
```

Assembler (PSB/DBD) use `***...***` line comments:
```hlasm
***********************************************************************
* Licensed Materials - Property of IBM
*
* (c) Copyright IBM Corp. 2026.
***********************************************************************
```

#### 2.3 IDENTIFICATION DIVISION — MUST follow

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROGNAME.
       AUTHOR. FirstName LastName.
```
- `AUTHOR.` clause is required in CICS programs; optional in IMS programs
- Program name: 8 characters max, uppercase
- No DATE-WRITTEN or DATE-COMPILED clauses

#### 2.4 ENVIRONMENT DIVISION — MUST follow

```cobol
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      *SOURCE-COMPUTER.   IBM-370 WITH DEBUGGING MODE.
       SOURCE-COMPUTER.  IBM-370.
       OBJECT-COMPUTER.  IBM-370.

       INPUT-OUTPUT SECTION.
```
- The debugging mode line MUST remain commented out (with `*`)
- `SOURCE-COMPUTER` and `OBJECT-COMPUTER` are always `IBM-370`

---

### Step 3: Apply DATA DIVISION Standards

#### 3.1 WORKING-STORAGE Layout — MUST follow

The standard CICS WORKING-STORAGE opening pattern:
```cobol
       WORKING-STORAGE SECTION.

       01 WS-CICS-WORK-AREA.
          05 WS-CICS-RESP              PIC S9(8) COMP.
          05 WS-CICS-RESP2             PIC S9(8) COMP.

       01 WS-FAIL-INFO.
          05 FILLER                    PIC X(9)  VALUE 'PROGNAME '.
          05 WS-CICS-FAIL-MSG          PIC X(70) VALUE ' '.
          05 FILLER                    PIC X(6)  VALUE ' RESP='.
          05 WS-CICS-RESP-DISP         PIC 9(10) VALUE 0.
          05 FILLER                    PIC X(7)  VALUE ' RESP2='.
          05 WS-CICS-RESP2-DISP        PIC 9(10) VALUE 0.
          05 FILLER                    PIC X(15) VALUE ' ABENDING TASK.'.
```

#### 3.2 Level Numbering Convention — MUST follow

Use the following level progression:
- `01` — top-level group
- `05` — first sub-level (**not** `03`)
- `10` — second sub-level
- `15`, `20`, etc. — deeper nesting

```cobol
       01 WS-DATE-AREA.
          05 WS-ORIG-DATE              PIC X(10).
          05 WS-ORIG-DATE-GRP REDEFINES WS-ORIG-DATE.
             10 WS-ORIG-DATE-DD        PIC 99.
             10 FILLER                 PIC X.
             10 WS-ORIG-DATE-MM        PIC 99.
             10 FILLER                 PIC X.
             10 WS-ORIG-DATE-YYYY      PIC 9999.
```

Exception: Standalone level `77` items are acceptable for single-use control counters (e.g., `77 SYSIDERR-RETRY PIC 999`).

#### 3.3 Variable Naming — MUST follow

| Scope / Type | Prefix | Example |
|---|---|---|
| Working Storage | `WS-` | `WS-CUSTOMER-NO-NUM` |
| DB2 Host Variable group | `HOST-<TABLE>-ROW` | `HOST-CUSTOMER-ROW` |
| DB2 Host Variable fields | `HV-<TABLE>-<FIELD>` | `HV-CUSTOMER-SORTCODE` |
| ABEND info record | `ABND-` | `ABND-SQLCODE`, `ABND-FREEFORM` |
| CICS response work area | `WS-CICS-` | `WS-CICS-RESP` |
| Date/time work fields | `WS-ORIG-DATE`, `WS-U-TIME` | (as shown) |
| IMS segment areas | No prefix; descriptive with `-SEG` or `-CA` suffix | `CUSTOMER-SEG`, `CUSTACCS-SEG` |
| IMS I/O areas | `INPUT-AREA`, `OUTPUT-AREA` | (literal names) |
| IMS PCB masks | Descriptive: `LTERMPCB`, `DBPCB` | (literal names) |
| PL/I host variables | `HV_<TABLE>_<FIELD>` (underscores) | `HV_CUST_NUMBER` |

All COBOL names: **UPPERCASE with hyphens**, max 30 characters.
All PL/I names: **UPPERCASE with underscores**.

#### 3.4 DB2 Declarations — MUST follow

DB2 table structures are **always** included via `EXEC SQL INCLUDE`, never via `COPY`:
```cobol
      * CUSTOMER DB2 copybook
           EXEC SQL
              INCLUDE CUSTDB2
           END-EXEC.

      * CUSTOMER host variables for DB2
       01 HOST-CUSTOMER-ROW.
          05 HV-CUSTOMER-EYECATCHER     PIC X(4).
          05 HV-CUSTOMER-SORTCODE       PIC X(6).
          ...

      * Pull in the SQL COMMAREA
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.

       01 SQLCODE-DISPLAY               PIC S9(8) DISPLAY
              SIGN LEADING SEPARATE.
```

#### 3.5 Level 88 Condition Names — MUST follow

Use level 88 for all boolean flags, datastore selectors, and status values:
```cobol
       01 DATA-STORE-TYPE               PIC X.
          88 DATASTORE-TYPE-DLI                   VALUE '1'.
          88 DATASTORE-TYPE-DB2                   VALUE '2'.
          88 DATASTORE-TYPE-VSAM                  VALUE 'V'.

       01 SWITCHES.
          05 VALID-DATA-SW              PIC X VALUE 'Y'.
             88 VALID-DATA              VALUE 'Y'.
```

#### 3.6 REDEFINES for Date Groups — MUST follow

The standard date decomposition pattern:
```cobol
       01 WS-ORIG-DATE                  PIC X(10).
       01 WS-ORIG-DATE-GRP REDEFINES WS-ORIG-DATE.
          05 WS-ORIG-DATE-DD            PIC 99.
          05 FILLER                     PIC X.
          05 WS-ORIG-DATE-MM            PIC 99.
          05 FILLER                     PIC X.
          05 WS-ORIG-DATE-YYYY          PIC 9999.

       01 WS-ORIG-DATE-GRP-X.
          05 WS-ORIG-DATE-DD-X          PIC XX.
          05 FILLER                     PIC X VALUE '.'.
          05 WS-ORIG-DATE-MM-X          PIC XX.
          05 FILLER                     PIC X VALUE '.'.
          05 WS-ORIG-DATE-YYYY-X        PIC X(4).
```

#### 3.7 LOCAL-STORAGE vs WORKING-STORAGE — MUST follow (CICS only)

- `WORKING-STORAGE SECTION`: static data shared across CICS pseudo-conversational invocations
- `LOCAL-STORAGE SECTION`: task-local variables initialized fresh each invocation (retry counters, loop exit flags, output data areas, COPY of business data structures)

```cobol
       LOCAL-STORAGE SECTION.
       01 FILE-RETRY                    PIC 999.
       01 WS-EXIT-RETRY-LOOP            PIC X         VALUE ' '.
       01 WS-CUST-DATA.
          COPY CUSTOMER.
```

#### 3.8 Abend Infrastructure — MUST follow (CICS programs)

Every CICS program MUST declare the abend helper program and info record:
```cobol
       01 WS-ABEND-PGM                  PIC X(8) VALUE 'ABNDPROC'.
       01 ABNDINFO-REC.
          COPY ABNDINFO.
```

#### 3.9 LINKAGE SECTION — MUST follow (CICS programs)

```cobol
       LINKAGE SECTION.
       01 DFHCOMMAREA.
          COPY <PROGRAMNAME>Z.
```
(Or the inline commarea structure if no copybook exists.)

#### 3.10 IMS Declarations — MUST follow (IMS programs)

DL/I function codes as `77` items in WORKING-STORAGE:
```cobol
       77  GU                  PIC  X(04)        VALUE "GU  ".
       77  GHU                 PIC  X(04)        VALUE "GHU ".
       77  GN                  PIC  X(04)        VALUE "GN  ".
       77  GHN                 PIC  X(04)        VALUE "GHN ".
       77  ISRT                PIC  X(04)        VALUE "ISRT".
       77  REPL                PIC  X(04)        VALUE "REPL".
       77  GE                  PIC  X(02)        VALUE "GE".
       77  GB                  PIC  X(02)        VALUE "GB".
```

Error status display record:
```cobol
       01  BAD-STATUS.
           05  SC-MSG  PIC X(30) VALUE "BAD STATUS CODE WAS RECEIVED: ".
           05  SC             PIC X(2).
```

LINKAGE SECTION for IMS pointer-based PCB access:
```cobol
       LINKAGE SECTION.
       01  IOPCBA POINTER.
       01  DBPCB1 POINTER.
```

PCB mask structures in LINKAGE SECTION:
```cobol
       01  LTERMPCB.
           05  LOGTTERM        PIC  X(08).
           05  FILLER          PIC  X(02).
           05  TPSTAT          PIC  X(02).
           ...
       01  DBPCB.
           05  DBDNAME         PIC  X(08).
           05  SEGLEVEL        PIC  X(02).
           05  DBSTAT          PIC  X(02).
           ...
```

---

### Step 4: Apply PROCEDURE DIVISION Standards

#### 4.1 CICS Entry Pattern — MUST follow

```cobol
       PROCEDURE DIVISION USING DFHCOMMAREA.
       PREMIERE SECTION.
       P010.
      *
      *    Set up abend handling
      *
           EXEC CICS HANDLE ABEND
              LABEL(ABEND-HANDLING)
           END-EXEC.
           ...

       P999.
           EXIT.
```
- Main section always named `PREMIERE SECTION`
- First paragraph: `P010` (or `A010` for BMS programs with EVALUATE TRUE logic)
- Last paragraph of each section: `Xnnn999. EXIT.` where X+nnn matches the first paragraph

#### 4.2 Paragraph Naming — MUST follow

Format: **VERB-NOUN** or **VERB-NOUN-NOUN**, uppercase, hyphenated:
```
READ-CUSTOMER-DB2
POPULATE-TIME-DATE
GET-ME-OUT-OF-HERE
ABEND-HANDLING
GENERATE-RANDOM-CUSTOMER
```
IMS programs also use `<NAME>-END` as section terminators:
```
GET-CUSTOMER-DATA.
    ...
GET-CUSTOMER-DATA-END.
```

#### 4.3 CICS Program Termination — MUST follow

```cobol
       GET-ME-OUT-OF-HERE SECTION.
       GMOFH010.
      *
      *    Finish
      *
           EXEC CICS RETURN
           END-EXEC.

       GMOFH999.
           EXIT.
```

#### 4.4 IMS Program Entry and Termination — MUST follow

```cobol
       PROCEDURE DIVISION.
             ENTRY "DLITCBL"
             USING  IOPCBA, DBPCB1.

       BEGIN.
           MOVE 0 TO TERM-IO.
           SET ADDRESS OF LTERMPCB TO ADDRESS OF IOPCBA.
           ...
           STOP RUN.
```

#### 4.5 CICS Abend Handling Pattern — MUST follow

When a CICS error (bad SQLCODE, bad RESP, unexpected condition) is detected:
1. `INITIALIZE ABNDINFO-REC`
2. Populate `ABND-` fields (SQLCODE, RESPCODE, RESP2CODE)
3. `EXEC CICS ASSIGN APPLID(ABND-APPLID) END-EXEC`
4. `MOVE EIBTASKN TO ABND-TASKNO-KEY` / `MOVE EIBTRNID TO ABND-TRANID`
5. `PERFORM POPULATE-TIME-DATE`
6. `STRING` the diagnostic message `INTO ABND-FREEFORM`
7. `EXEC CICS LINK PROGRAM(WS-ABEND-PGM) COMMAREA(ABNDINFO-REC) END-EXEC`
8. `EXEC CICS ABEND ABCODE('XXXX') CANCEL END-EXEC`

#### 4.6 DB2 SQLCODE Checking Pattern — MUST follow

```cobol
           IF SQLCODE = 0
              MOVE 'Y' TO EXIT-VSAM-READ
              ...
           END-IF.

           IF SQLCODE = 100
              ...  (not-found handling)
           END-IF.

           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
              INITIALIZE ABNDINFO-REC
              MOVE SQLCODE TO ABND-SQLCODE
              ... (full abend sequence)
           END-IF.
```

#### 4.7 CICS Command Style — MUST follow

- `EXEC CICS` commands on their own line, indented 11 spaces from margin
- Parameters each on their own continuation line, indented further
- `END-EXEC.` on its own line
- Always use `RESP(WS-CICS-RESP) RESP2(WS-CICS-RESP2)` on commands that support it

```cobol
           EXEC CICS READ
                DATASET('CUSTFILE')
                INTO(WS-CUST-DATA)
                RIDFLD(DESIRED-CUST-KEY)
                KEYLENGTH(LENGTH OF DESIRED-CUST-KEY)
                RESP(WS-CICS-RESP)
                RESP2(WS-CICS-RESP2)
           END-EXEC.
```

#### 4.8 DL/I Call Style — MUST follow (IMS programs)

```cobol
           CALL 'CBLTDLI' USING GU, DBPCB, CUSTOMER-SEG, CUSTOMER-SSA1.
```
Or with line continuation for multiple arguments:
```cobol
           CALL 'CBLTDLI'
             USING GU, DBPCB, CUSTOMER-SEG, CUSTOMER-SSA1.
```

#### 4.9 SQL Statement Style — MUST follow (DB2 programs)

```cobol
           EXEC SQL
              SELECT COL1, COL2, COL3
                INTO :HV-COL1, :HV-COL2, :HV-COL3
                FROM TABLE_NAME
               WHERE SORT_COL = :HV-SORT-COL
                 AND KEY_COL  = :HV-KEY-COL
           END-EXEC.
```
- `EXEC SQL` on its own line
- SQL keywords uppercase, one clause per line
- Host variables prefixed with `:`
- `END-EXEC.` on its own line

---

### Step 5: Apply PL/I Standards

#### 5.1 Variable Naming — MUST follow

- All identifiers: `UPPERCASE_WITH_UNDERSCORES`
- Host variables: `HV_<TABLE>_<FIELD>` (e.g., `HV_CUST_NUMBER`)
- Working variables: descriptive uppercase (e.g., `TRANS_COUNT`, `END_OF_DATA`)
- Constants (INIT values): declared as `DCL name type INIT(value)`
- Structure levels: `1/5/10` (not `01/05/10`)

#### 5.2 Section Headers — MUST follow

```pli
  /*------------------------------------------------------------*
  * PROCEDURE: PROC_NAME
  * Description of what this procedure does
  *------------------------------------------------------------*/
  PROC_NAME: PROCEDURE;
```

#### 5.3 Error Handling — MUST follow

```pli
   ON ENDFILE(file_name)
     BEGIN;
       ...
     END;
   ON ERROR
     BEGIN;
       PUT SKIP LIST('Error in PROC_NAME');
       PUT SKIP LIST('Error code:', ONCODE());
       SIGNAL ERROR;
     END;
```

---

### Step 6: Apply JCL Standards

#### 6.1 Job Card — MUST follow

```jcl
//JOBNAME  JOB 'Description',NOTIFY=&SYSUID,CLASS=A,MSGCLASS=H,
//          MSGLEVEL=(1,1),REGION=4M
```

#### 6.2 Comment Style — MUST follow

Use simple `//****` comment lines (minimum 4 asterisks):
```jcl
//********************************************
//*MONTH FOR WHICH REPORT IS RUN
//********************************************
```

#### 6.3 DSN References

Use fully qualified dataset names. Subsystem library references:
```jcl
//STEPLIB  DD  DISP=SHR,DSN=DB2V13.SDSNEXIT
//         DD  DISP=SHR,DSN=DB2V13.SDSNLOAD
```

---

### Step 7: Apply Assembler (PSB/DBD) Standards

#### 7.1 PSB Structure — MUST follow

```hlasm
***********************************************************************
* Licensed Materials - Property of IBM
***********************************************************************
        PCB    TYPE=DB,DBDNAME=<DBDNAME>,PROCOPT=<OPT>,KEYLEN=<N>,    C
               PCBNAME=<NAME>
        SENSEG NAME=<SEGNAME>,PARENT=0
        ...
        PSBGEN PSBNAME=<PSBNAME>,LANG=COBOL
        END
```

#### 7.2 DBD Structure — MUST follow

```hlasm
***********************************************************************
* <AppName> - <ENTITY> DBD
***********************************************************************
      DBD   NAME=<NAME>,                                               C
               ENCODING=Cp1047,                                        C
               ACCESS=(<ACCESSMETHOD>),                                C
               ...
      DATASET  DD1=<NAME>, ...
      SEGM  NAME=<NAME>, ...
      FIELD NAME=(<FIELDNAME>,SEQ,U), ...
      FIELD NAME=<FIELDNAME>, ...
      DBDGEN
      FINISH
      END
```

#### 7.3 Continuation Lines

All macro continuations use `C` in column 72. Operands indented consistently to column 16.

---

### Step 8: Cross-Cutting Rules

#### 8.1 No Hardcoded Credentials or Literal Dataset Names in Logic
- Sortcodes and configuration values: use named counters or JCL parameters — not literal values embedded in business logic

#### 8.2 Inline Comments
- Use `*` in column 7 for full-line COBOL comments
- Use `D` in column 7 for debug-conditional display statements
- Comment style: brief English phrase, not restating what the code does
```cobol
      *
      *    Set up abend handling
      *
```

#### 8.3 Scope Terminators
- All `IF`/`EVALUATE`/`PERFORM`/`READ`/`STRING`/`EXEC` blocks MUST use explicit scope terminators (`END-IF`, `END-EVALUATE`, `END-PERFORM`, `END-READ`, `END-STRING`, `END-EXEC`)

#### 8.4 GOBACK vs STOP RUN
- CICS programs: end with `EXEC CICS RETURN END-EXEC` then `GOBACK.`
- IMS COBOL batch: end with `STOP RUN.`
- PL/I: end with `RETURN;`

---

### Step 9: Report Findings

When reviewing code, structure your response as:

```
## Standards Review Results

**Overall Compliance:** [Excellent|Good|Needs Improvement|Poor]

### Critical Issues (Must Fix)
- [Issue with line number and explanation]

### Recommendations (Should Fix)
- [Recommendation]

### Positive Observations
- [What's done well]
```

---

### Step 10: Provide Corrected Code (if requested)

1. Show the problematic section
2. Explain the violation
3. Provide corrected version with explanation

---

### Step 11: Validate with ZCodeScan

**MANDATORY**: After generating or modifying COBOL or PL/I code, always instruct users to validate the code quality with ZCodeScan.

Before running ZCodeScan, verify there is a rules file in the workspace (check `zcodescan/zcodescan-rules.yaml` or `zcodescan/bankofz-naming-rules.yaml`). The schema is at https://github.com/IBM/zopeneditor-about/blob/main/zcodescan/zcodescan-rules-1.4.0.json

Add this instruction at the end of every code generation response:

```
IMPORTANT: Validate the generated code with ZCodeScan

Run ZCodeScan on the new or modified file to validate code quality:
- Use the "zcodescan-check-current-program" MCP tool for the current file
- Or "zcodescan-check-list-of-local-programs" with pattern "**/*.cbl" for all COBOL files

Review and resolve any reported issues before finalising the code.
```

**MANDATORY**: Always add "Validate generated code with ZCodeScan" as the last step in any TODO list for code generation tasks.

---

## Enforcement Levels Summary

| Category | Level | Rule |
|---|---|---|
| Compiler directive (line 1) | Must | Exact format per subsystem |
| Copyright + description block | Must | IBM copyright + prose description |
| Level numbering (01/05/10) | Must | 05 as first sub-level under 01 |
| WS-/HV- prefixes | Must | Per naming table |
| LOCAL-STORAGE vs WS (CICS) | Must | Separate per-invocation data |
| ABNDPROC/ABNDINFO pattern | Must | All CICS programs |
| DFHCOMMAREA in LINKAGE | Must | All CICS programs |
| PREMIERE SECTION entry | Must | All CICS programs |
| EXEC CICS RETURN at end | Must | All CICS programs |
| DB2: EXEC SQL INCLUDE | Must | Never use COPY for DB2 tables |
| DB2: SQLCODE 0/100/else pattern | Must | All DB2 programs |
| IMS: 77-level DL/I codes | Must | All IMS programs |
| IMS: CALL 'CBLTDLI' style | Must | All IMS programs |
| Scope terminators | Must | All programs |
| Level 88 for conditions | Must | All programs |
| Author clause | Must (CICS) / Advisory (IMS) | Per subsystem |
| GOBACK vs STOP RUN | Must | Per subsystem |
| Sub-level 03 (avoid) | Must | Use 05 instead |
| DISPLAY for debug | Should | With D in column 7 |
| Inline comment style | Should | Brief English, column 7 |

## Review Checklist

- [ ] Compiler directive correct for subsystem
- [ ] Copyright + description block present
- [ ] Level numbering: 01/05/10 (not 03)
- [ ] Variable names follow prefix conventions
- [ ] DB2: `EXEC SQL INCLUDE` not `COPY`; SQLCA included
- [ ] DB2 host variable group named `HOST-<TABLE>-ROW` with `HV-` fields
- [ ] SQLCODE check: 0 / 100 / else pattern
- [ ] CICS: ABNDPROC infrastructure declared and used on errors
- [ ] CICS: `PREMIERE SECTION` / `P010` entry pattern
- [ ] CICS: `GET-ME-OUT-OF-HERE` exit pattern
- [ ] CICS: `EXEC CICS HANDLE ABEND` at top of PREMIERE
- [ ] IMS: 77-level DL/I codes declared
- [ ] IMS: `ENTRY "DLITCBL"` in PROCEDURE DIVISION
- [ ] Scope terminators on all blocks
- [ ] Level 88 conditions for flags and status
- [ ] LOCAL-STORAGE used for task-local data (CICS)
- [ ] ZCodeScan run after generation

## References

- `references/discovered-patterns.md` — Full pattern analysis with statistics
- `references/code-samples.md` — Actual code snippets from BANKZ programs
- `references/z-language-patterns.md` — Z-specific pattern detection library

---

**Usage:** Reference this skill by saying "Apply BANKZ coding standards" or "Review this code using BANKZ standards" or "Generate code following BANKZ conventions".

**Maintenance:** Update this skill when standards evolve. Re-run the Z Coding Standards Skill Builder quarterly or after major refactoring.
