# BANKZ Code Samples

Actual code snippets extracted from BANKZ source files illustrating the coding standards.

---

## COBOL — CICS Program Header (Good)

From [`INQCUST.cbl`](../../../src/base/cics/cobol/INQCUST.cbl):

```cobol
       CBL CICS('SP,EDF')
       CBL SQL
      ******************************************************************
      *                                                                *
      *  Copyright IBM Corp. 2023                                      *
      *                                                                *
      ******************************************************************

      ******************************************************************
      * This program takes customer number as input
      * and returns to the calling program a commarea containing all of
      * the customer information for that record.
      *
      * What gets returned is the CUSTOMER data if the CUSTOMER is
      * found or a CUSTOMER record set to low values if a matching
      * CUSTOMER record could not be found.
      *
      * If there is any kind of problem then an appropriate abend is
      * issued.
      *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. INQCUST.
       AUTHOR. Jon Collett.
```

**Why this is good:**
- `CBL` directives on line 1, correct for CICS+SQL program
- IBM copyright box present
- Free-form prose description (not keyword-based)
- `AUTHOR.` clause present (required for CICS programs)

---

## COBOL — IMS Program Header (Good)

From [`IBGCUDAT.cbl`](../../../src/base/ims/cobol/IBGCUDAT.cbl):

```cobol
       CBL LIST,MAP,XREF,FLAG(I)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. IBGCUDAT.

      ******************************************************************
      * Licensed Materials - Property of IBM
      *
      * (c) Copyright IBM Corp. 2026.
      ******************************************************************
```

**Why this is good:**
- `CBL LIST,MAP,XREF,FLAG(I)` on line 1 (IMS COBOL standard)
- `PROGRAM-ID.` before copyright (IMS convention)
- No `AUTHOR.` clause (acceptable for IMS programs)

---

## COBOL — Standard CICS Working Storage Opening (Good)

From [`BNKMENU.cbl`](../../../src/base/cics/cobol/BNKMENU.cbl):

```cobol
       WORKING-STORAGE SECTION.

       01 WS-CICS-WORK-AREA.
          05 WS-CICS-RESP              PIC S9(8) COMP VALUE 0.
          05 WS-CICS-RESP2             PIC S9(8) COMP VALUE 0.

       01 WS-FAIL-INFO.
          05 FILLER                    PIC X(9)  VALUE 'BNKMENU  '.
          05 WS-CICS-FAIL-MSG          PIC X(70) VALUE ' '.
          05 FILLER                    PIC X(6)  VALUE ' RESP='.
          05 WS-CICS-RESP-DISP         PIC 9(10) VALUE 0.
          05 FILLER                    PIC X(7)  VALUE ' RESP2='.
          05 WS-CICS-RESP2-DISP        PIC 9(10) VALUE 0.
          05 FILLER                    PIC X(15) VALUE ' ABENDING TASK.'.
```

**Why this is good:**
- `05` as the first sub-level under `01` (standard)
- `WS-CICS-WORK-AREA` is the mandatory CICS response area
- `WS-FAIL-INFO` captures fail info for diagnostics
- Consistent naming with `WS-` prefix

---

## COBOL — Anti-Pattern: Wrong Sub-Level (Bad)

Found in older programs (INQCUST.cbl working-storage area):

```cobol
       01 WS-CICS-WORK-AREA.
          03 WS-CICS-RESP              PIC S9(8) COMP.   ← WRONG
          03 WS-CICS-RESP2             PIC S9(8) COMP.   ← WRONG
```

**Why this is wrong:**
- `03` should be `05` — resolved standard is `01/05/10`

---

## COBOL — DB2 Host Variables (Good)

From [`CRECUST.cbl`](../../../src/base/cics/cobol/CRECUST.cbl):

```cobol
      * CUSTOMER DB2 copybook
           EXEC SQL
             INCLUDE CUSTDB2
             END-EXEC.

      * CUSTOMER host variables for DB2
       01 HOST-CUSTOMER-ROW.
          05 HV-CUSTOMER-EYECATCHER     PIC X(4).
          05 HV-CUSTOMER-SORTCODE       PIC X(6).
          05 HV-CUSTOMER-NUMBER         PIC X(10).
          05 HV-CUSTOMER-TITLE          PIC X(10).
          05 HV-CUSTOMER-FIRST-NAME     PIC X(50).
          05 HV-CUSTOMER-LAST-NAME      PIC X(50).
          05 HV-CUSTOMER-DOB            PIC S9(9) COMP.
          ...

      * Pull in the SQL COMMAREA
           EXEC SQL
          INCLUDE SQLCA
           END-EXEC.

       01 SQLCODE-DISPLAY               PIC S9(8) DISPLAY
              SIGN LEADING SEPARATE.
```

**Why this is good:**
- DB2 include via `EXEC SQL INCLUDE` (never `COPY`)
- `01 HOST-<TABLE>-ROW` group name pattern
- `05 HV-<TABLE>-<FIELD>` field naming
- SQLCA included
- `SQLCODE-DISPLAY` for diagnostic formatting

---

## COBOL — CICS Abend Infrastructure (Good)

From [`INQCUST.cbl`](../../../src/base/cics/cobol/INQCUST.cbl):

Working storage:
```cobol
       01 WS-ABEND-PGM                 PIC X(8) VALUE 'ABNDPROC'.

       01 ABNDINFO-REC.
          COPY ABNDINFO.
```

Abend invocation (on DB2 error):
```cobol
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
              INITIALIZE ABNDINFO-REC
              MOVE SQLCODE TO ABND-SQLCODE

              EXEC CICS ASSIGN APPLID(ABND-APPLID)
              END-EXEC

              MOVE EIBTASKN   TO ABND-TASKNO-KEY
              MOVE EIBTRNID   TO ABND-TRANID

              PERFORM POPULATE-TIME-DATE

              MOVE WS-ORIG-DATE TO ABND-DATE
              STRING 'RCD010 - CUSTOMER DB2 SELECT KEY='
                    DELIMITED BY SIZE,
                    CUSTOMER-KY DELIMITED SIZE,
                    ' GAVE SQLCODE=' DELIMITED BY SIZE,
                    SQLCODE-DISPLAY DELIMITED BY SIZE
                    INTO ABND-FREEFORM
              END-STRING

              EXEC CICS LINK PROGRAM(WS-ABEND-PGM)
                        COMMAREA(ABNDINFO-REC)
              END-EXEC

              EXEC CICS ABEND ABCODE('CVR1')
                 CANCEL
              END-EXEC

           END-IF.
```

---

## COBOL — CICS PREMIERE SECTION Pattern (Good)

From [`INQCUST.cbl`](../../../src/base/cics/cobol/INQCUST.cbl):

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


       READ-CUSTOMER-DB2 SECTION.
       RCD010.
      *
      *    Read customer from DB2
      *
           ...
       RCD999.
           EXIT.


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

---

## COBOL — SQLCODE Checking Pattern (Good)

From [`INQCUST.cbl`](../../../src/base/cics/cobol/INQCUST.cbl):

```cobol
           IF SQLCODE = 0
              MOVE 'Y' TO EXIT-VSAM-READ
              MOVE 'Y' TO INQCUST-INQ-SUCCESS
              ...
              GO TO RCD999
           END-IF.

           IF SQLCODE = 100 AND
              INQCUST-CUSTNO = 0000000000
              ... (not-found, random customer)
           END-IF.

           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
              INITIALIZE ABNDINFO-REC
              ... (full abend sequence)
           END-IF.
```

---

## COBOL — REDEFINES Date Pattern (Good)

From multiple CICS programs:

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

---

## COBOL — IMS DL/I Call Codes Pattern (Good)

From [`IBGCUDAT.cbl`](../../../src/base/ims/cobol/IBGCUDAT.cbl):

```cobol
      ******************************************************************
      *DATABASE CALL CODES
      ******************************************************************

       77  GU                  PIC  X(04)        VALUE "GU  ".
       77  GHU                 PIC  X(04)        VALUE "GHU ".
       77  GN                  PIC  X(04)        VALUE "GN  ".
       77  GHN                 PIC  X(04)        VALUE "GHN ".
       77  ISRT                PIC  X(04)        VALUE "ISRT".
       77  REPL                PIC  X(04)        VALUE "REPL".

      ******************************************************************
      *IMS STATUS CODES
      ******************************************************************

       77  GE                  PIC  X(02)        VALUE "GE".
       77  GB                  PIC  X(02)        VALUE "GB".

      ******************************************************************
      *ERROR STATUS CODE AREA
      ******************************************************************

       01  BAD-STATUS.
           05  SC-MSG  PIC X(30) VALUE "BAD STATUS CODE WAS RECEIVED: ".
           05  SC             PIC X(2).
```

---

## COBOL — IMS Segment Search Argument (Good)

From [`IBGCUDAT.cbl`](../../../src/base/ims/cobol/IBGCUDAT.cbl):

```cobol
      *    CUSTOMER-SSA1 IS USED TO FIND INFO FROM THE CUSTOMER RECORD
      *    SELECT ... WHERE sa.customer.custid = ?
       01  CUSTOMER-SSA1.
           05  FILLER          PIC  X(08)        VALUE "CUSTOMER".
           05  FILLER          PIC  X(01)        VALUE "(".
           05  FILLER          PIC  X(08)        VALUE "CUSTID  ".
           05  FILLER          PIC  X(02)        VALUE "EQ".
           05  CUSTID          PIC  S9(9) COMP-5 VALUE +0.
           05  FILLER          PIC  X(01)        VALUE ")".
           05  FILLER          PIC  X(01)        VALUE ' '.
```

---

## COBOL — Level 88 Condition Names (Good)

From [`DBCRFUN.cbl`](../../../src/base/cics/cobol/DBCRFUN.cbl):

```cobol
       01 DATA-STORE-TYPE               PIC X.
          88 DATASTORE-TYPE-DLI                       VALUE '1'.
          88 DATASTORE-TYPE-DB2                       VALUE '2'.
          88 DATASTORE-TYPE-VSAM                      VALUE 'V'.
```

From [`BNK1CCA.cbl`](../../../src/base/cics/cobol/BNK1CCA.cbl):

```cobol
       01 FLAGS.
           05 SEND-FLAG               PIC X.
              88 SEND-ERASE           VALUE '1'.
              88 SEND-DATAONLY        VALUE '2'.
              88 SEND-DATAONLY-ALARM  VALUE '3'.
```

From [`CUSTOMER.cpy`](../../../src/base/cics/copy/CUSTOMER.cpy):

```cobol
          05 CUSTOMER-STATUS                     PIC X(10).
             88 CUSTOMER-STATUS-ACTIVE           VALUE 'ACTIVE'.
             88 CUSTOMER-STATUS-INACTIVE         VALUE 'INACTIVE'.
             88 CUSTOMER-STATUS-SUSPENDED        VALUE 'SUSPENDED'.
```

---

## PL/I — Variable and Structure Declarations (Good)

From [`BNKSTMT.pli`](../../../src/base/batch/pli/BNKSTMT.pli):

```pli
  /*------------------------------------------------------------*
  * HOST VARIABLE DECLARATIONS FOR CUSTOMER TABLE
  *------------------------------------------------------------*/
  DCL
   1 HV_CUSTOMER,
    5 HV_CUST_EYECATCHER      CHAR(4),
    5 HV_CUST_SORTCODE        CHAR(6),
    5 HV_CUST_NUMBER          CHAR(10),
    5 HV_CUST_FIRST_NAME      CHAR(50),
    ...

  DCL TRANS_COUNT             FIXED BIN(15) INIT(0);
  DCL END_OF_DATA             BIT(1) INIT('0'B);
```

---

## JCL — Job Card Pattern (Good)

From [`BNKSTMT.jcl`](../../../src/base/batch/jcl/BNKSTMT.jcl):

```jcl
//BNKSTMT JOB 'Report',NOTIFY=&SYSUID,CLASS=A,MSGCLASS=H,
//          MSGLEVEL=(1,1),REGION=4M
//STEP1    EXEC PGM=IKJEFT01
//STEPLIB  DD  DISP=SHR,DSN=DB2V13.SDSNEXIT
//         DD  DISP=SHR,DSN=DB2V13.SDSNLOAD
//********************************************
//*MONTH FOR WHICH REPORT IS RUN
//********************************************
```

---

## Assembler — PSB Structure (Good)

From [`IBTRAN.asm`](../../../src/base/ims/PSB/IBTRAN.asm):

```hlasm
***********************************************************************
* Licensed Materials - Property of IBM
***********************************************************************
        PCB    TYPE=DB,DBDNAME=ACCOUNT,PROCOPT=R,KEYLEN=8,             C
               PCBNAME=ACCOUNT
        SENSEG NAME=ACCOUNT,PARENT=0
        PCB    TYPE=DB,DBDNAME=CUSTACCS,PROCOPT=G,KEYLEN=12,           C
               PCBNAME=CUSTACCS
        SENSEG NAME=CUSTACCS,PARENT=0
        PSBGEN PSBNAME=IBTRAN,LANG=COBOL
        END
```
