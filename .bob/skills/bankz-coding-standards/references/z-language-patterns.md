# BANKZ Z Language Pattern Library

Reference for detecting and classifying patterns in BANKZ IBM Z source code.

---

## Subsystem Detection

### CICS Detection (Strong indicators — 100% confidence)
- `CBL CICS(` on line 1
- `PROCESS CICS,` on line 1
- `EXEC CICS` anywhere in code
- `DFHCOMMAREA` in LINKAGE SECTION
- `EIBCALEN`, `EIBDATE`, `EIBTRNID`, `EIBTASKN` references
- `PREMIERE SECTION` as main entry section
- `EXEC CICS RETURN END-EXEC` as program exit

### IMS Detection (Strong indicators — 100% confidence)
- `CBL LIST,MAP,XREF,FLAG(I)` on line 1 (COBOL)
- `*PROCESS SYSTEM(IMS);` on line 1 (PL/I)
- `77  GU   PIC X(04) VALUE "GU  ".` working storage block
- `CALL 'CBLTDLI'` or `CALL PLITDLI` in procedure division
- `ENTRY "DLITCBL"` in PROCEDURE DIVISION
- PCB mask structures: `LTERMPCB`, `DBPCB`
- `STOP RUN.` as termination (batch IMS)

### DB2 Detection (Strong indicators — 100% confidence)
- `CBL SQL` on line 1
- `EXEC SQL` anywhere
- `EXEC SQL INCLUDE SQLCA` or `EXEC SQL INCLUDE SQLCA;`
- `SQLCODE` checking
- `HOST-<TABLE>-ROW` group names
- `HV-<FIELD>` prefixed variables (COBOL) or `HV_<FIELD>` (PL/I)
- Cursor declarations with `EXEC SQL DECLARE ... CURSOR FOR`

### Batch/DB2 PL/I Detection
- `EXEC SQL INCLUDE SQLCA;` (PL/I syntax with semicolon)
- `DCL 1 HV_<TABLE>,` structure declarations
- `EXEC SQL DECLARE ... CURSOR FOR SELECT`
- `ON ENDFILE(...)` / `ON ERROR` handlers

### Assembler PSB Detection
- File in `src/base/ims/PSB/` directory with `.asm` extension
- `PCB TYPE=DB,DBDNAME=` macro
- `SENSEG NAME=` macro
- `PSBGEN PSBNAME=,LANG=COBOL` macro

### Assembler DBD Detection
- File in `src/base/ims/DBD/` directory with `.asm` extension
- `DBD NAME=` macro
- `DATASET DD1=` macro
- `SEGM NAME=` macro
- `FIELD NAME=` macro

---

## COBOL Naming Pattern Detection

### Working Storage Prefixes
```regex
^\s+(01|05|10|15|77)\s+WS-[A-Z0-9-]+
```
→ `WS-` prefix: working storage variable

```regex
^\s+(01|05)\s+HOST-[A-Z]+-ROW\.
```
→ `HOST-<TABLE>-ROW`: DB2 host variable group

```regex
^\s+(05|10)\s+HV-[A-Z]+-[A-Z-]+\s+PIC
```
→ `HV-` prefix: DB2 host variable field

### Paragraph Naming
```regex
^[A-Z][A-Z0-9]+-[A-Z][A-Z0-9-]+\.$
```
→ VERB-NOUN paragraph name (standard BANKZ format)

```regex
^[A-Z][A-Z0-9]{2}[0-9]{3}\.$
```
→ Section paragraph (e.g., `RCD010.`, `P999.`, `GMOFH010.`)

### Section Exit Paragraphs
```regex
^[A-Z][A-Z0-9]{2}999\.$
```
→ Exit paragraph (e.g., `RCD999.`, `P999.`, `GMOFH999.`)

---

## Code Era Detection for BANKZ

### Enterprise COBOL Indicators (All BANKZ programs)
- `LOCAL-STORAGE SECTION` present
- `SET ADDRESS OF ... TO ADDRESS OF ...`
- `COMPUTE ... FUNCTION MOD(...)` — intrinsic functions
- `FUNCTION NUMVAL(...)` 
- `EVALUATE TRUE ... WHEN ... END-EVALUATE`
- Scope terminators (`END-IF`, `END-PERFORM`) throughout — no period-terminated IF chains
- `USAGE POINTER` declarations
- `PROGRAM-ID. "IBTRAN" recursive.` (OO feature, IBTRAN only)

---

## Copybook Usage Patterns

### CICS Copybooks (src/base/cics/copy/)
| Copybook | Purpose | Include Pattern |
|---|---|---|
| SORTCODE | Bank sort code constant | `COPY SORTCODE.` in WS |
| CUSTOMER | Customer data structure | `01 OUTPUT-DATA. COPY CUSTOMER.` |
| ACCOUNT | Account data structure | `01 WS-ACC-DATA. COPY ACCOUNT.` |
| ABNDINFO | Abend info record | `01 ABNDINFO-REC. COPY ABNDINFO.` |
| DFHAID | CICS AID key definitions | `COPY DFHAID.` at group level |
| PROCTRAN | Processed transaction | `01 PROCTRAN-AREA. COPY PROCTRAN.` |
| <PROG>Z | CICS commarea structure | `01 DFHCOMMAREA. COPY <PROG>Z.` |

### IMS Copybooks (src/base/ims/copy/)
| Copybook | Purpose |
|---|---|
| IBTRAN.cpy | IBTRAN commarea/API |
| IBSHIST.cpy / IBGHIST.cpy | IMS history data |
| JNI.cpy | Java Native Interface definitions |

---

## SQL Statement Style Patterns

### Column-per-Line SELECT (BANKZ standard)
```cobol
           EXEC SQL
              SELECT COL1,
                     COL2,
                     COL3
                INTO :HV-COL1,
                     :HV-COL2,
                     :HV-COL3
                FROM TABLE_NAME
               WHERE SORT_COL = :HV-SORT-COL
           END-EXEC.
```

### Single-line Column SELECT (also used)
```cobol
           EXEC SQL
              SELECT COL1, COL2, COL3
                INTO :HV-COL1, :HV-COL2, :HV-COL3
                FROM TABLE_NAME
               WHERE KEY = :HV-KEY
           END-EXEC.
```

---

## IMS SSA Construction Patterns

### Qualified SSA (with condition)
```cobol
       01  CUSTOMER-SSA1.
           05  FILLER          PIC  X(08)        VALUE "CUSTOMER".
           05  FILLER          PIC  X(01)        VALUE "(".
           05  FILLER          PIC  X(08)        VALUE "CUSTID  ".
           05  FILLER          PIC  X(02)        VALUE "EQ".
           05  CUSTID          PIC  S9(9) COMP-5 VALUE +0.
           05  FILLER          PIC  X(01)        VALUE ")".
           05  FILLER          PIC  X(01)        VALUE ' '.
```
- Segment name: 8 bytes (pad with spaces)
- Operator field: `EQ`, `= ` (with trailing space)
- Key field: typed to match segment field
- FILLER for all fixed portions

### Unqualified SSA (no condition)
```cobol
       01  CUSTOMER-SSA.
           05  FILLER          PIC  X(08)        VALUE "CUSTOMER".
           05  FILLER          PIC  X(01)        VALUE ' '.
```
- Segment name + space (no parentheses)

---

## Abend Code Conventions

BANKZ uses 4-character abend codes in EXEC CICS ABEND:
- `CVR1` — Customer VSAM/DB2 Read error (INQCUST)
- `HROL` — Syncpoint rollback failure
- `AFCR`, `AFCS`, `AFCT` — VSAM RLS conditions (handled via storm drain)
- Pattern: short mnemonic indicating program area + error type

---

## File/Dataset Naming Conventions

### JCL Dataset Names
- Format: `<QUALIFIER>.<SUBSYSTEM>.<TYPE>`
- Examples: `DB2V13.SDSNEXIT`, `BANKZ.V0R1M0.LOAD`, `DB2V13.SDSNLOAD`
- Load library: `BANKZ.V0R1M0.LOAD`
- DB2 plan: `BANKZPLN`

### CICS File Names (in EXEC CICS commands)
- Uppercase, matches FD/SELECT name
- Examples: `CUSTFILE`, `ABNDFILE`, `PROCTRAN`

---

## Comment Style Reference

### COBOL Full-Line Comment
```cobol
      * Brief English description
```
Column 7 asterisk, space, text.

### COBOL Section Header Comment
```cobol
      *
      *    Set up abend handling
      *
```
Three-line pattern: blank comment, indented text, blank comment.

### COBOL Debug-Only Display
```cobol
      D       DISPLAY 'DEBUG VALUE=' SOME-FIELD
```
`D` in column 7 — compiled only with `SOURCE-COMPUTER. IBM-370 WITH DEBUGGING MODE.`

### COBOL Section Divider (IMS programs)
```cobol
      ******************************************************************
      *SECTION HEADING TEXT
      ******************************************************************
```

### PL/I Section Header
```pli
  /*------------------------------------------------------------*
  * PROCEDURE: PROC_NAME
  * Purpose description
  *------------------------------------------------------------*/
```

### Assembler Section Comment
```hlasm
***********************************************************************
*        SEGMENT NAME
***********************************************************************
```
