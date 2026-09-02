# BANKZ Discovered Patterns — Full Analysis

**Analysis Date:** 2025-07-14  
**Files Analyzed:** 30 source files (20 COBOL deep-read, 5 copybooks, 2 PL/I, 1 JCL, 2 Assembler)  
**Enforcement Level:** Moderate

---

## File Inventory

### CICS COBOL Programs (src/base/cics/cobol/)
- INQCUST.cbl — Customer inquiry, DB2 + VSAM, CICS, large
- CRECUST.cbl — Customer create, DB2, CICS, large
- UPDCUST.cbl — Customer update, DB2, CICS
- DBCRFUN.cbl — Debit/credit function, DB2, CICS, large
- XFRFUN.cbl — Transfer function, DB2, CICS, large
- ABNDPROC.cbl — Abend processor (centralized), VSAM, CICS
- CREACC.cbl — Account create, DB2, CICS
- BNKMENU.cbl — BMS menu program, CICS
- BNK1CCA.cbl — Account listing BMS program, CICS
- GETSCODE.cbl — Sort code retrieval utility, CICS (small)
- BANKDATA.cbl — Data initialization utility
- + 9 more (BNK1*, INQ*, DEL*, UPD*)

### IMS COBOL Programs (src/base/ims/cobol/)
- IBGCUDAT.cbl — Get customer data, IMS DL/I
- IBTRAN.cbl — Transaction handler, IMS DL/I + Java bridge
- LOADCUST.cbl — Customer data loader, IMS batch
- IBACSUM.cbl — Account summary, IMS DL/I
- IBSCUDAT.cbl — Set customer data, IMS DL/I
- IBLOGIN1.cbl, IBLOGOUT.cbl, IBLOGIN1.cbl, LOADHIST.cbl, LOADTSTA.cbl, LOADACCT.cbl, LOADCUSA.cbl

### PL/I Programs
- src/base/batch/pli/BNKSTMT.pli — Batch statement generator, DB2
- src/base/ims/pli/IBLOGIN.pli — IMS login handler, DL/I

### JCL
- src/base/batch/jcl/BNKSTMT.jcl

### Assembler
- src/base/ims/PSB/IBTRAN.asm — IMS PSB
- src/base/ims/DBD/CUSTOMER.asm — IMS DBD

---

## Pattern Scores by Category

### Compiler Directives (Line 1)
| Pattern | Files | Confidence |
|---|---|---|
| CICS: `PROCESS CICS,NODYNAM,NSYMBOL(NATIONAL),TRUNC(STD)` + `CBL CICS('SP,EDF')` | 14/14 CICS | 100% |
| CICS: `CBL SQL` added when DB2 used | 12/12 DB2-CICS | 100% |
| CICS: `CBL CICS('SP,EDF,DLI')` when DLI involved | 3/3 applicable | 100% |
| IMS COBOL: `CBL LIST,MAP,XREF,FLAG(I)` | 9/9 IMS COBOL | 100% |
| IMS PL/I: `*PROCESS SYSTEM(IMS);` | 1/1 IMS PL/I | 100% |

### Copyright + Description Block
| Pattern | Files | Confidence |
|---|---|---|
| IBM copyright box comment block | 20/20 COBOL | 100% |
| Free-form prose description block | 20/20 COBOL | 100% |
| PL/I box comment `/*----*` style | 2/2 PL/I | 100% |
| Assembler `***...***` line comments | 2/2 ASM | 100% |
| Keyword headers (PROGRAM/PURPOSE/DATE) | **0/20** | **0% — NOT used** |

### Program Header Fields
| Pattern | Files | Confidence |
|---|---|---|
| `AUTHOR.` clause | 14/14 CICS | 100% CICS; 0% IMS |
| `SOURCE-COMPUTER. IBM-370.` | 20/20 | 100% |
| Commented-out `*SOURCE-COMPUTER. IBM-370 WITH DEBUGGING MODE.` | 20/20 | 100% |

### Working Storage Prefixes
| Pattern | Files | Confidence |
|---|---|---|
| `WS-` prefix for working storage | 17/20 | 85% |
| `WS-CICS-RESP` / `WS-CICS-RESP2` naming | 14/14 CICS | 100% |
| `HV-` prefix for DB2 host variables | 14/14 DB2 COBOL | 100% |
| `HOST-<TABLE>-ROW` group name | 14/14 DB2 COBOL | 100% |
| `ABND-` prefix for abend info fields | All using ABNDINFO | 100% |
| No prefix in IMS segment structures | 9/9 IMS | 100% |

### Level Numbering
| Pattern | Files | Confidence |
|---|---|---|
| `05` as first sub-level under `01` | 12/20 COBOL | 60% observed (RESOLVED: standard is 05) |
| `03` as first sub-level (anti-pattern) | 8/20 COBOL | Legacy — to be corrected |

### DB2 Integration
| Pattern | Files | Confidence |
|---|---|---|
| `EXEC SQL INCLUDE` for DB2 copybooks | 14/14 DB2 | 100% |
| `EXEC SQL INCLUDE SQLCA` | 14/14 DB2 | 100% |
| `SQLCODE-DISPLAY PIC S9(8) DISPLAY SIGN LEADING SEPARATE` | 12/14 | 86% |
| SQLCODE check: 0 / 100 / else | 4/4 checked | 100% |
| PL/I: `HV_<TABLE>_<FIELD>` with underscores | 1/1 PL/I | 100% |

### CICS Structural Patterns
| Pattern | Files | Confidence |
|---|---|---|
| `PREMIERE SECTION` main section | 20/20 CICS | 100% |
| `EXEC CICS HANDLE ABEND LABEL(ABEND-HANDLING)` | 18/20 CICS | 90% |
| `GET-ME-OUT-OF-HERE SECTION` exit pattern | 18/20 CICS | 90% |
| `EXEC CICS RETURN END-EXEC` at end | 20/20 CICS | 100% |
| `DFHCOMMAREA` in LINKAGE SECTION | 20/20 CICS | 100% |
| `PROCEDURE DIVISION USING DFHCOMMAREA` | 20/20 CICS | 100% |
| `WS-ABEND-PGM VALUE 'ABNDPROC'` | 18/20 CICS | 90% |
| Full ABEND sequence (INIT/POPULATE/LINK/ABEND) | 18/20 CICS | 90% |
| `GOBACK.` after final EXEC CICS RETURN | 15/20 CICS | 75% |

### IMS Structural Patterns
| Pattern | Files | Confidence |
|---|---|---|
| 77-level GU/GHU/GN/GHN/ISRT/REPL/GE/GB codes | 9/9 IMS | 100% |
| `CALL 'CBLTDLI'` for DL/I calls | 9/9 IMS | 100% |
| `ENTRY "DLITCBL" USING IOPCBA, DBPCB1` | 8/9 IMS | 89% |
| `SET ADDRESS OF <PCB> TO ADDRESS OF <PTR>` pattern | 8/9 IMS | 89% |
| `BAD-STATUS` 01 group for status display | 9/9 IMS | 100% |
| `STOP RUN` termination | 9/9 IMS | 100% |
| PCB masks in LINKAGE (`LTERMPCB`, `DBPCB`) | 9/9 IMS | 100% |
| SSA using FILLER for fixed keyword parts | 8/9 IMS | 89% |

### Scope Terminators
| Pattern | Files | Confidence |
|---|---|---|
| `END-IF` used | 20/20 | 100% |
| `END-PERFORM` used | 20/20 | 100% |
| `END-EXEC` used | 20/20 | 100% |
| `END-STRING` used | 10/10 applicable | 100% |
| `END-READ` used | 8/8 applicable | 100% |

### Level 88 Usage
| Pattern | Files | Confidence |
|---|---|---|
| Level 88 for datastore type flags | 14/14 CICS | 100% |
| Level 88 for BMS send flags | 8/8 BMS | 100% |
| Level 88 for status values in copybooks | 3/3 copybooks | 100% |

### PL/I Patterns
| Pattern | Files | Confidence |
|---|---|---|
| `UPPERCASE_WITH_UNDERSCORES` naming | 2/2 PL/I | 100% |
| `1/5/10` level numbers | 2/2 PL/I | 100% |
| `/*----*` box comment style | 2/2 PL/I | 100% |
| `ON ENDFILE/ON ERROR` handlers | 2/2 PL/I | 100% |
| `EXEC SQL INCLUDE SQLCA` | 1/1 DB2 PL/I | 100% |

### Assembler (PSB/DBD)
| Pattern | Files | Confidence |
|---|---|---|
| Copyright comment block first | 16/16 ASM | 100% |
| `C` continuation in column 72 | 16/16 ASM | 100% |
| `PSBGEN PSBNAME=...,LANG=COBOL` | 8/8 PSB | 100% |
| `DBDGEN/FINISH/END` for DBD | 8/8 DBD | 100% |

---

## Conflicts Resolved

| Conflict | Options Found | Resolution |
|---|---|---|
| First sub-level under 01 | `03` (8 files) vs `05` (12 files) | **Standard: `05`** (user confirmed) |
| EXEC SQL indentation | 8 spaces vs 7 spaces | Minor; 8 spaces recommended |

---

## Code Era

All COBOL programs are **Enterprise COBOL**:
- Scope terminators throughout
- `LOCAL-STORAGE SECTION` (Enterprise COBOL feature)
- `COMPUTE ... FUNCTION MOD(...)` and `FUNCTION NUMVAL`
- `EVALUATE TRUE` with WHEN conditions (BMS programs)
- Pointer usage (`USAGE POINTER`, `SET ADDRESS OF`)
- `PROGRAM-ID. "IBTRAN" recursive.` (IBTRAN.cbl — Java bridge)

No COBOL-74 or COBOL-85 legacy patterns found.
