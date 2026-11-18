       PROCESS NODLL,NODYNAM,TEST(NOSEP),NOCICS,NOSQL,PGMN(LU),NOSEQ
       PROCESS ARITH(COMPAT)
      *-----------------------------------------------------------------
      * IBM Early Development Testing generated test
      *  Product ID: 5900-BBG
      *  Build: 2026-10-29T08:09:10Z (v3.1.1-SNAPSHOT)
      *   Level: [20261029T080350Z-ce409be35]
      *  Version: COBOL_DRUN V3.0.0
      *
      * Program: INQCUST
      * Data origin: Generated
      * Data source: /Users/monvorath/datGitWorkspaces/Bank-of-Z/.edt-un
      *    it-test/testdata/test_INQCUST/testData2.json
      * Codepage: IBM1047
      *
      * Test ID: 0b2b27f9-e169-4e60-8515-e09a31aa36f1
      * Generated: 11/03/2026 15:17
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'BEFORE_ALL'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  TEST-CASE-DATA.
           03 TEST-VERSION       PIC  9(05) COMP VALUE 1.
           03 NUM-TESTS          PIC  9(05) COMP VALUE 1.
           03 TEST-CASE-TYPE     PIC  X(04)      VALUE 'CICS'.
           03 TEST-CASE-UUID     PIC  X(36)
                           VALUE '0b2b27f9-e169-4e60-8515-e09a31aa36f1'.
           03 FILLER             PIC  X(128).
           03 TEST-ARRAY             OCCURS 1 TIMES.
             05 TEST-UUID        PIC  X(36).
             05 TEST-NAME        PIC  X(80).
             05 TEST-EP-NAME     PIC  X(160).
             05 TEST-BEFORE-EACH PIC  X(160)     VALUE 'BEFORE_EACH'.
             05 TEST-AFTER-EACH  PIC  X(160)     VALUE 'AFTER_EACH'.
             05 LOAD-MODULE-NAME PIC  X(08)      VALUE 'INQCUST'.
             05 CSECT-NAME       PIC  X(72)      VALUE SPACES.
       01  TC-DATA-PTR           POINTER.
       01  EQAUTCFG              PIC  X(08)      VALUE 'EQAUTCFG'.
       PROCEDURE DIVISION.
      *****************************************************************
      * Establish the test case information
      *****************************************************************
           DISPLAY 'RUNNING TEST CASE'.
      *****************************************************************
      * Establish individual test case arguments for TEST2
      *****************************************************************
           MOVE 'TEST2' TO TEST-NAME(1).
           MOVE 'TEST_TEST2' TO TEST-EP-NAME(1).
           MOVE 'e7288405-7b8d-470e-8c7e-67abc2f36abb'
               TO TEST-UUID(1).
      *****************************************************************
      * Inform the engine of the test case configuration
      *****************************************************************
           SET TC-DATA-PTR TO ADDRESS OF TEST-CASE-DATA.
           CALL EQAUTCFG USING TC-DATA-PTR.
           GOBACK.
       END PROGRAM 'BEFORE_ALL'.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'TEST_TEST2'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  LOAD-MODULE-NAME    PIC  X(08) VALUE 'INQCUST'.
       01  CSECT-NAME          PIC  X(72) VALUE SPACES.
       01  TEST-NAME-LENGTH    PIC S9(04) COMP-5 VALUE ZERO.
       01  TEST-NAME-TRIMMED   PIC  X(80)        VALUE SPACES.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 5.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01  BZ-TRACE.
           03 TRACE-LEN        PIC S9(04) COMP-4 VALUE 5.
           03 TRACE-TXT        PIC  X(254)       VALUE 'TRACE'.
       01  BZUGETEP            PIC  X(08)        VALUE 'BZUGETEP'.
       01  BZUTRACE            PIC  X(08)        VALUE 'BZUTRACE'.
       01  AZ-EP-PTR           POINTER.
       01  AZ-TRACE-PTR        POINTER.
       01  ASSERT-ST.
           03 ASSERT-RC        PIC  9(09) BINARY VALUE 4.
           03 ASSERT-TEXT      PIC  9(04) BINARY VALUE 0.
       01  AZ-RC-WORK          PIC S9(04) BINARY VALUE 0.
       01  AZ-TEST-INPUT-DATA-VALUE.
           03 AZU00000000 PIC X(4) VALUE SPACES.
           03 AZU00000001 PIC X(6) VALUE '987654'.
           03 AZU00000002 PIC X(10) VALUE SPACES.
           03 AZU00000003 PIC X(50) VALUE SPACES.
           03 AZU00000004 PIC X(50) VALUE SPACES.
           03 AZU00000005 PIC X(20) VALUE SPACES.
           03 AZU00000006 PIC X(50) VALUE SPACES.
           03 AZU00000007 PIC X(50) VALUE SPACES.
           03 AZU00000008 PIC X(50) VALUE SPACES.
           03 AZU00000009 PIC X(10) VALUE SPACES.
           03 AZU0000000A PIC X(50) VALUE SPACES.
           03 AZU0000000B PIC X(10) VALUE SPACES.
           03 AZU0000000C PIC X(1) VALUE SPACES.
           03 AZU0000000D PIC X(1) VALUE SPACES.
           03 AZU0000000E PIC X(4) VALUE SPACES.
       01  AZ-DFHEIBLK-PTR     POINTER EXTERNAL.
       01  AZ-DFHCOMMAREA-PTR  POINTER EXTERNAL.
       01  DFHCOMMAREA.
           03 INQCUST-EYE PIC X(4).
           03 INQCUST-SCODE PIC X(6).
           03 INQCUST-CUSTNO PIC 9(10).
           03 INQCUST-NAME.
             05 INQCUST-TITLE PIC X(10).
             05 INQCUST-FIRST-NAME PIC X(50).
             05 INQCUST-LAST-NAME PIC X(50).
           03 INQCUST-DOB.
             05 INQCUST-DOB-DD PIC 99.
             05 INQCUST-DOB-MM PIC 99.
             05 INQCUST-DOB-YYYY PIC 9999.
           03 INQCUST-PHONE PIC X(20).
           03 INQCUST-ADDR.
             05 INQCUST-ADDR-LINE1 PIC X(50).
             05 INQCUST-ADDR-LINE2 PIC X(50).
             05 INQCUST-CITY PIC X(50).
             05 INQCUST-POSTCODE PIC X(10).
             05 INQCUST-COUNTRY PIC X(50).
           03 INQCUST-STATUS PIC X(10).
           03 INQCUST-CREATED-DATE.
             05 INQCUST-CREATED-DD PIC 99.
             05 INQCUST-CREATED-MM PIC 99.
             05 INQCUST-CREATED-YYYY PIC 9999.
           03 INQCUST-CREDIT-SCORE PIC 999.
           03 INQCUST-CS-REVIEW-DT.
             05 INQCUST-CS-REVIEW-DD PIC 99.
             05 INQCUST-CS-REVIEW-MM PIC 99.
             05 INQCUST-CS-REVIEW-YYYY PIC 9999.
           03 INQCUST-INQ-SUCCESS PIC X.
           03 INQCUST-INQ-FAIL-CD PIC X.
           03 INQCUST-PCB-POINTER PIC X(4).
       01  Dfheiblk.
             02 EIBTIME PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBTIME-AZ REDEFINES EIBTIME.
             03 PIC X(4).
             02 EIBDATE PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBDATE-AZ REDEFINES EIBDATE.
             03 PIC X(4).
             02 EIBTRNID PIC X(4).
             02 EIBTASKN PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBTASKN-AZ REDEFINES EIBTASKN.
             03 PIC X(4).
             02 EIBTRMID PIC X(4).
             02 DFHEIGDI PIC S9(4) USAGE COMP-5.
             02 EIBCPOSN PIC S9(4) USAGE COMP-5.
             02 EIBCALEN PIC S9(4) USAGE COMP-5.
             02 EIBAID PIC X(1).
             02 EIBFN PIC X(2).
             02 EIBRCODE PIC X(6).
             02 EIBDS PIC X(8).
             02 EIBREQID PIC X(8).
             02 EIBRSRCE PIC X(8).
             02 EIBSYNC PIC X.
             02 EIBFREE PIC X.
             02 EIBRECV PIC X.
             02 EIBSEND PIC X.
             02 EIBATT PIC X.
             02 EIBEOC PIC X.
             02 EIBFMH PIC X.
             02 EIBCOMPL PIC X(1).
             02 EIBSIG PIC X(1).
             02 EIBCONF PIC X(1).
             02 EIBERR PIC X(1).
             02 EIBERRCD PIC X(4).
             02 EIBSYNRB PIC X.
             02 EIBNODAT PIC X.
             02 EIBRESP PIC S9(8) USAGE BINARY.
             02 EIBRESP2 PIC S9(8) USAGE BINARY.
             02 EIBRLDBK PIC X(1).
       LINKAGE SECTION.
       01  TEST-NAME           PIC  X(80).
       01  AZ-ARG-LIST.
           03 ARG-LENGTH       PIC  9(04) COMP-4.
           03 ARG-DATA         PIC  X(256).
       01  AZ-INFO-BLOCK.
           COPY EQAITERC.
       01  AZ-PROC-PTR         PROCEDURE-POINTER.
       PROCEDURE DIVISION USING TEST-NAME
                                AZ-ARG-LIST
                                AZ-INFO-BLOCK
           .
       0000-MAINLINE-SECTION SECTION.
       0010-MAINLINE.
           DISPLAY 'AZU0000I TEST_TEST2 STARTED...'
           PERFORM 9010-TRIM-TEST-NAME
      * INITIALIZE PARAMETER
      * SET AREA ADDRESS TO POINTER
      * SET DFH PARAMETER ADDRESS TO POINTER
           SET AZ-DFHEIBLK-PTR TO ADDRESS OF Dfheiblk.
           SET AZ-DFHCOMMAREA-PTR TO ADDRESS OF DFHCOMMAREA.
      * SET INPUT VALUE
           MOVE 0 TO RETURN-CODE.
           MOVE AZU00000000 TO INQCUST-EYE
           MOVE AZU00000001 TO INQCUST-SCODE
           MOVE 42 TO INQCUST-CUSTNO
           MOVE AZU00000002 TO INQCUST-TITLE
           MOVE AZU00000003 TO INQCUST-FIRST-NAME
           MOVE AZU00000004 TO INQCUST-LAST-NAME
           MOVE 0 TO INQCUST-DOB-DD
           MOVE 0 TO INQCUST-DOB-MM
           MOVE 0 TO INQCUST-DOB-YYYY
           MOVE AZU00000005 TO INQCUST-PHONE
           MOVE AZU00000006 TO INQCUST-ADDR-LINE1
           MOVE AZU00000007 TO INQCUST-ADDR-LINE2
           MOVE AZU00000008 TO INQCUST-CITY
           MOVE AZU00000009 TO INQCUST-POSTCODE
           MOVE AZU0000000A TO INQCUST-COUNTRY
           MOVE AZU0000000B TO INQCUST-STATUS
           MOVE 0 TO INQCUST-CREATED-DD
           MOVE 0 TO INQCUST-CREATED-MM
           MOVE 0 TO INQCUST-CREATED-YYYY
           MOVE 0 TO INQCUST-CREDIT-SCORE
           MOVE 0 TO INQCUST-CS-REVIEW-DD
           MOVE 0 TO INQCUST-CS-REVIEW-MM
           MOVE 0 TO INQCUST-CS-REVIEW-YYYY
           MOVE AZU0000000C TO INQCUST-INQ-SUCCESS
           MOVE AZU0000000D TO INQCUST-INQ-FAIL-CD
           MOVE AZU0000000E TO INQCUST-PCB-POINTER
           MOVE X'0093000C0126307CD6C4C3E20019444CF0F0F0F1000000000193C5
      -    'D3C940404040404040404040404040404040404040404040404040404040
      -    '40404040404040404040404040404040404040000000000000000040' TO
            Dfheiblk
      * CALL TEST PROGRAM
           DISPLAY 'AZU0000I CALL INQCUST'
           CALL BZUGETEP USING BY REFERENCE LOAD-MODULE-NAME
                               CSECT-NAME
                         RETURNING AZ-EP-PTR
           IF AZ-EP-PTR = NULL
             MOVE 1 TO MESSAGE-LEN OF BZ-ASSERT
             STRING 'UNABLE TO GET THE ENTRY POINT BY BZUGETEP.'
               DELIMITED BY SIZE
               INTO MESSAGE-TXT OF BZ-ASSERT
               WITH POINTER MESSAGE-LEN OF BZ-ASSERT
             END-STRING
             SUBTRACT 1 FROM MESSAGE-LEN OF BZ-ASSERT
             PERFORM THROW-ASSERTION-M
             GOBACK
           .
           SET ADDRESS OF AZ-PROC-PTR TO AZ-EP-PTR
           CALL AZ-PROC-PTR
           USING Dfheiblk DFHCOMMAREA
           .
      * EVALUATE OUTPUT VALUE
           MOVE 0 TO RETURN-CODE
      * END
           DISPLAY 'AZU0000I TEST_TEST2 END.'
           GOBACK
           .
       THROW-ASSERTION-M.
           DISPLAY 'AZU0000I ------------------------------------------'
           DISPLAY 'AZU2001W THE TEST "' TEST-NAME-TRIMMED
                                         '" FAILED DUE TO AN ASSERTION.'
           DISPLAY 'AZU1101I ' MESSAGE-TXT OF
                                   BZ-ASSERT(1:MESSAGE-LEN OF BZ-ASSERT)
           DISPLAY 'AZU0000I ------------------------------------------'
           CALL BZUASSRT USING BZ-P1
                               BZ-P2
                               BZ-P3
                               BZ-ASSERT
           .
       9000-UTILITY-SECTION SECTION.
       9010-TRIM-TEST-NAME.
           MOVE 0 TO TEST-NAME-LENGTH
           INSPECT TEST-NAME TALLYING TEST-NAME-LENGTH
               FOR CHARACTERS BEFORE INITIAL SPACE
           MOVE TEST-NAME(1:TEST-NAME-LENGTH) TO TEST-NAME-TRIMMED
           .
       END PROGRAM 'TEST_TEST2'.
      *-----------------------------------------------------------------
      * TEST'S MAIN CALLBACK ROUTINE
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'BZU_TEST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  LOAD-MODULE-NAME    PIC  X(08) VALUE 'INQCUST'.
       01  CSECT-NAME          PIC  X(72) VALUE SPACES.
       01 TESTCASE-METADATA.
           05 TM-PGM-UNDER-TEST-PATH PIC X(200) VALUE
           "src/base/cics/cobol/INQCUST.cbl".
       01  TEST-NAME-LENGTH    PIC S9(04) COMP-5 VALUE ZERO.
       01  TEST-NAME-TRIMMED   PIC  X(80)        VALUE SPACES.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 5.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01  BZ-TRACE.
           03 TRACE-LEN        PIC S9(04) COMP-4 VALUE 5.
           03 TRACE-TXT        PIC  X(254)       VALUE 'TRACE'.
       01  BZUTRACE            PIC  X(08)        VALUE 'BZUTRACE'.
       01  AZ-TRACE-PTR        POINTER.
       01  ASSERT-ST.
           03 ASSERT-RC        PIC  9(09) BINARY VALUE 4.
           03 ASSERT-TEXT      PIC  9(04) BINARY VALUE 0.
       01  AZ-GRP-INDEX        PIC  9(08).
       01  AZ-FLAG-IN          PIC  9(01).
       01  AZ-RECORD-PTR       POINTER.
       01  AZ-RC-WORK          PIC S9(04) BINARY.
       01  AZ-OUTPUT-COUNT-STR PIC  X(05).
       LINKAGE SECTION.
       01  TEST-NAME           PIC  X(80).
       01  AZ-INFO-BLOCK.
          COPY EQAITERC.
       01  AZ-ARG-LIST.
           03 ARG-LENGTH       PIC  9(04) COMP-4.
           03 ARG-DATA         PIC  X(256).
       01  DFHCOMMAREA.
           03 INQCUST-EYE PIC X(4).
           03 INQCUST-SCODE PIC X(6).
           03 INQCUST-CUSTNO PIC 9(10).
           03 INQCUST-NAME.
             05 INQCUST-TITLE PIC X(10).
             05 INQCUST-FIRST-NAME PIC X(50).
             05 INQCUST-LAST-NAME PIC X(50).
           03 INQCUST-DOB.
             05 INQCUST-DOB-DD PIC 99.
             05 INQCUST-DOB-MM PIC 99.
             05 INQCUST-DOB-YYYY PIC 9999.
           03 INQCUST-PHONE PIC X(20).
           03 INQCUST-ADDR.
             05 INQCUST-ADDR-LINE1 PIC X(50).
             05 INQCUST-ADDR-LINE2 PIC X(50).
             05 INQCUST-CITY PIC X(50).
             05 INQCUST-POSTCODE PIC X(10).
             05 INQCUST-COUNTRY PIC X(50).
           03 INQCUST-STATUS PIC X(10).
           03 INQCUST-CREATED-DATE.
             05 INQCUST-CREATED-DD PIC 99.
             05 INQCUST-CREATED-MM PIC 99.
             05 INQCUST-CREATED-YYYY PIC 9999.
           03 INQCUST-CREDIT-SCORE PIC 999.
           03 INQCUST-CS-REVIEW-DT.
             05 INQCUST-CS-REVIEW-DD PIC 99.
             05 INQCUST-CS-REVIEW-MM PIC 99.
             05 INQCUST-CS-REVIEW-YYYY PIC 9999.
           03 INQCUST-INQ-SUCCESS PIC X.
           03 INQCUST-INQ-FAIL-CD PIC X.
           03 INQCUST-PCB-POINTER PIC X(4).
       01  Dfheiblk.
             02 EIBTIME PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBTIME-AZ REDEFINES EIBTIME.
             03 PIC X(4).
             02 EIBDATE PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBDATE-AZ REDEFINES EIBDATE.
             03 PIC X(4).
             02 EIBTRNID PIC X(4).
             02 EIBTASKN PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBTASKN-AZ REDEFINES EIBTASKN.
             03 PIC X(4).
             02 EIBTRMID PIC X(4).
             02 DFHEIGDI PIC S9(4) USAGE COMP-5.
             02 EIBCPOSN PIC S9(4) USAGE COMP-5.
             02 EIBCALEN PIC S9(4) USAGE COMP-5.
             02 EIBAID PIC X(1).
             02 EIBFN PIC X(2).
             02 EIBRCODE PIC X(6).
             02 EIBDS PIC X(8).
             02 EIBREQID PIC X(8).
             02 EIBRSRCE PIC X(8).
             02 EIBSYNC PIC X.
             02 EIBFREE PIC X.
             02 EIBRECV PIC X.
             02 EIBSEND PIC X.
             02 EIBATT PIC X.
             02 EIBEOC PIC X.
             02 EIBFMH PIC X.
             02 EIBCOMPL PIC X(1).
             02 EIBSIG PIC X(1).
             02 EIBCONF PIC X(1).
             02 EIBERR PIC X(1).
             02 EIBERRCD PIC X(4).
             02 EIBSYNRB PIC X.
             02 EIBNODAT PIC X.
             02 EIBRESP PIC S9(8) USAGE BINARY.
             02 EIBRESP2 PIC S9(8) USAGE BINARY.
             02 EIBRLDBK PIC X(1).
       01  AZ-RECORD-COUNT     PIC 9(05) COMP-5.
      /
       PROCEDURE DIVISION.
       0000-MAINLINE-SECTION SECTION.
       0010-ENTRY-FOR-PGM-INPUT.
           ENTRY "PGM_INPT_INQCUST"
                 USING TEST-NAME
                       AZ-INFO-BLOCK
           DFHCOMMAREA Dfheiblk.
           DISPLAY 'AZU0000I PGM_INPT_INQCUST INPUT VALUES...'.
           MOVE 0 TO RETURN-CODE
           PERFORM 9010-TRIM-TEST-NAME
      *
           EVALUATE TEST-NAME-TRIMMED
           WHEN SPACE
             CONTINUE
           WHEN OTHER
             CONTINUE
           END-EVALUATE
      *
           PERFORM 9020-TEARDOWN
           GOBACK
           .
       0020-ENTRY-FOR-PGM-OUTPUT.
           ENTRY "PGM_OUTP_INQCUST"
                 USING TEST-NAME
                       AZ-INFO-BLOCK
           DFHCOMMAREA Dfheiblk.
           DISPLAY 'AZU0000I PGM_OUTP_INQCUST CHECK VALUES...'.
           MOVE 0 TO RETURN-CODE
           PERFORM 9010-TRIM-TEST-NAME
      *
           EVALUATE TEST-NAME-TRIMMED
           WHEN SPACE
             MOVE 4 TO RETURN-CODE
           WHEN 'TEST2'
             MOVE 0 TO RETURN-CODE
           WHEN OTHER
             MOVE 4 TO RETURN-CODE
           END-EVALUATE
      *
           PERFORM 9020-TEARDOWN
           GOBACK
           .
       9000-UTILITY-SECTION SECTION.
       9010-TRIM-TEST-NAME.
           MOVE 0 TO TEST-NAME-LENGTH
           INSPECT TEST-NAME TALLYING TEST-NAME-LENGTH
               FOR CHARACTERS BEFORE INITIAL SPACE
           MOVE TEST-NAME(1:TEST-NAME-LENGTH) TO TEST-NAME-TRIMMED
           .
       9020-TEARDOWN.
           DISPLAY 'AZU0000I BZU_TEST END.'
           .
       THROW-ASSERTION-M.
           DISPLAY 'AZU0000I ------------------------------------------'
           DISPLAY 'AZU2001W THE TEST "' TEST-NAME-TRIMMED
                                         '" FAILED DUE TO AN ASSERTION.'
           DISPLAY 'AZU1101I ' MESSAGE-TXT OF
                                   BZ-ASSERT(1:MESSAGE-LEN OF BZ-ASSERT)
           DISPLAY 'AZU0000I ------------------------------------------'
           CALL BZUASSRT USING BZ-P1
                               BZ-P2
                               BZ-P3
                               BZ-ASSERT
           .
       END PROGRAM 'BZU_TEST'.
      *-----------------------------------------------------------------
      * TEST'S INITIALIZATION ROUTINE
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'BEFORE_EACH'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  TEST-NAME-LENGTH    PIC S9(04) COMP-5 VALUE ZERO.
       01  TEST-NAME-TRIMMED   PIC  X(80)        VALUE SPACES.
       01  UNIQUE-TEST-ID      PIC  X(36)
                           VALUE '0b2b27f9-e169-4e60-8515-e09a31aa36f1'.
       LINKAGE SECTION.
       01  TEST-NAME           PIC  X(80).
       01  TEST-ID             PIC  X(80).
       01  AZ-INFO-BLOCK.
           COPY EQAITERC.
       PROCEDURE DIVISION USING TEST-NAME
                                TEST-ID
                                AZ-INFO-BLOCK
           .
       0000-MAINLINE-SECTION SECTION.
       0010-MAINLINE.
           PERFORM 9010-TRIM-TEST-NAME
           DISPLAY 'AZU0000I BEFORE_EACH: ' TEST-NAME-TRIMMED
           MOVE UNIQUE-TEST-ID TO TEST-ID
           GOBACK
           .
       9000-UTILITY-SECTION SECTION.
       9010-TRIM-TEST-NAME.
           MOVE 0 TO TEST-NAME-LENGTH
           INSPECT TEST-NAME TALLYING TEST-NAME-LENGTH
               FOR CHARACTERS BEFORE INITIAL SPACE
           MOVE TEST-NAME(1:TEST-NAME-LENGTH) TO TEST-NAME-TRIMMED
           .
       END PROGRAM 'BEFORE_EACH'.
      *-----------------------------------------------------------------
      * TEST'S TERMINATION ROUTINE
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'AFTER_EACH'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  TEST-NAME-LENGTH    PIC S9(04) COMP-5 VALUE ZERO.
       01  TEST-NAME-TRIMMED   PIC  X(80)        VALUE SPACES.
       LINKAGE SECTION.
       01  TEST-NAME            PIC  X(80).
       01  AZ-INFO-BLOCK.
           COPY EQAITERC.
       PROCEDURE DIVISION USING TEST-NAME
                                AZ-INFO-BLOCK
           .
       0000-MAINLINE-SECTION SECTION.
       0010-MAINLINE.
           PERFORM 9010-TRIM-TEST-NAME
           DISPLAY 'AZU0000I AFTER_EACH: ' TEST-NAME-TRIMMED
           GOBACK
           .
       9000-UTILITY-SECTION SECTION.
       9010-TRIM-TEST-NAME.
           MOVE 0 TO TEST-NAME-LENGTH
           INSPECT TEST-NAME TALLYING TEST-NAME-LENGTH
               FOR CHARACTERS BEFORE INITIAL SPACE
           MOVE TEST-NAME(1:TEST-NAME-LENGTH) TO TEST-NAME-TRIMMED
           .
       END PROGRAM 'AFTER_EACH'.
      *-----------------------------------------------------------------
      * TEST'S ROUTINE TO GET DATA AREA FOR RECORD COUNTS
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'GTMEMRC'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  BZUGTMEM            PIC  X(08) VALUE 'BZUGTMEM'.
       01  DATA-SIZE           PIC  9(08) COMP-4.
       LINKAGE SECTION.
       01  AZ-TC-WORK-AREA     PIC  X(256).
       01  AZ-GRP-INDEX        PIC  9(08).
       01  AZ-FLAG-IN          PIC  9(01).
       01  AZ-RECORD-PTR       POINTER.
       01  AZ-RECORD-PTR-VALUE
            REDEFINES AZ-RECORD-PTR PIC S9(09) COMP-5.
       01  DATA-PTR            POINTER.
       01  DATA-PTR-VALUE
            REDEFINES DATA-PTR PIC S9(09) COMP-5.
       01  DATA-AREA.
           03 RECORD-COUNT-IO OCCURS 17.
             05 RECORD-COUNT-OT PIC 9(05) COMP-5.
             05 RECORD-COUNT-IN PIC 9(05) COMP-5.
       01  WK-RECORD-COUNT     PIC  9(05) COMP-5.
       01  TEST-NAME           PIC  X(80).
       01  AZ-INFO-BLOCK.
          COPY EQAITERC.
       PROCEDURE DIVISION USING AZ-TC-WORK-AREA
                                AZ-GRP-INDEX
                                AZ-FLAG-IN
                                AZ-RECORD-PTR
           .
       0000-MAINLINE-SECTION SECTION.
       0010-MAINLINE.
           ENTRY "PGM_INPT_GTMEMRC" USING TEST-NAME
                                          AZ-INFO-BLOCK
                                          AZ-TC-WORK-AREA
                                          AZ-GRP-INDEX
                                          AZ-FLAG-IN
                                          AZ-RECORD-PTR
           SET ADDRESS OF DATA-PTR TO ADDRESS OF AZ-TC-WORK-AREA
           IF DATA-PTR-VALUE = 0
             COMPUTE DATA-SIZE = LENGTH OF WK-RECORD-COUNT * 2 * 17
             PERFORM 9020-CALL-BZUGTMEM
             SET ADDRESS OF DATA-AREA TO DATA-PTR
             DISPLAY 'AZU0000I AREA ALLOCATED FOR RECORD COUNT:'
           DATA-SIZE
           .
           SET AZ-RECORD-PTR TO DATA-PTR
           COMPUTE AZ-RECORD-PTR-VALUE = AZ-RECORD-PTR-VALUE +
             LENGTH OF WK-RECORD-COUNT * 2 * (AZ-GRP-INDEX - 1)
           IF AZ-FLAG-IN = 1
             ADD LENGTH OF WK-RECORD-COUNT TO AZ-RECORD-PTR-VALUE
           .
           SET ADDRESS OF WK-RECORD-COUNT TO AZ-RECORD-PTR
           GOBACK
           .
       9000-UTILITY-SECTION SECTION.
       9020-CALL-BZUGTMEM.
           CALL BZUGTMEM USING DATA-SIZE
                         RETURNING DATA-PTR
           .
       END PROGRAM 'GTMEMRC'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS HANDLE ABEND                    |
      *|    FUNCTION CODE: 0E0E                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_0E0E_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_0E0E_INQCUST.
           ENTRY 'CICS_INPT_0E0E_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E0E_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS HANDLE ABEND
           IF ARG0-1 = X'0E0E'
               MOVE 7 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS HANDLE ABEND L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_0E0E_INQCUST.
           ENTRY 'CICS_OUTP_0E0E_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E0E_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS HANDLE ABEND
           IF ARG0-1 = X'0E0E'
               MOVE 7 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS HANDLE ABEND L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_0E0E_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_0E0E_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS RETURN                          |
      *|    FUNCTION CODE: 0E08                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_0E08_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 2 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 2 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       01 AZ-COMPARE.
         03 AZ-COMPARE-ITEM-NAME-PTR POINTER.
         03 AZ-COMPARE-ITEM-NAME-LEN PIC S9(9) COMP-5.
         03 AZ-COMPARE-ITEM-VALUE-PTR POINTER.
         03 AZ-COMPARE-ITEM-VALUE-LEN PIC S9(9) COMP-5.
         03 AZ-COMPARE-ITEM-EXP-VALUE-PTR POINTER.
         03 AZ-COMPARE-ITEM-EXP-VALUE-LEN PIC S9(9) COMP-5.
         03 AZ-ITEM-NAME-S            PIC S9(8) COMP.
         03 AZ-ITEM-NAME-LEN          PIC S9(8) COMP.
       LOCAL-STORAGE SECTION.
       01  AZ-COMPARE-ITEM-NAMES.
           03 AZU00000000 PIC X(7) VALUE 'EIBTIME'.
           03 AZU00000002 PIC X(7) VALUE 'EIBDATE'.
           03 AZU00000004 PIC X(8) VALUE 'EIBTRNID'.
           03 AZU00000006 PIC X(8) VALUE 'EIBTASKN'.
           03 AZU00000008 PIC X(8) VALUE 'EIBTRMID'.
           03 AZU0000000A PIC X(8) VALUE 'DFHEIGDI'.
           03 AZU0000000C PIC X(8) VALUE 'EIBCPOSN'.
           03 AZU0000000E PIC X(8) VALUE 'EIBCALEN'.
           03 AZU00000010 PIC X(6) VALUE 'EIBAID'.
           03 AZU00000012 PIC X(5) VALUE 'EIBFN'.
           03 AZU00000014 PIC X(8) VALUE 'EIBRCODE'.
           03 AZU00000016 PIC X(5) VALUE 'EIBDS'.
           03 AZU00000018 PIC X(8) VALUE 'EIBREQID'.
           03 AZU0000001A PIC X(8) VALUE 'EIBRSRCE'.
           03 AZU0000001C PIC X(7) VALUE 'EIBSYNC'.
           03 AZU0000001E PIC X(7) VALUE 'EIBFREE'.
           03 AZU00000020 PIC X(7) VALUE 'EIBRECV'.
           03 AZU00000022 PIC X(7) VALUE 'EIBSEND'.
           03 AZU00000024 PIC X(6) VALUE 'EIBATT'.
           03 AZU00000026 PIC X(6) VALUE 'EIBEOC'.
           03 AZU00000028 PIC X(6) VALUE 'EIBFMH'.
           03 AZU0000002A PIC X(8) VALUE 'EIBCOMPL'.
           03 AZU0000002C PIC X(6) VALUE 'EIBSIG'.
           03 AZU0000002E PIC X(7) VALUE 'EIBCONF'.
           03 AZU00000030 PIC X(6) VALUE 'EIBERR'.
           03 AZU00000032 PIC X(8) VALUE 'EIBERRCD'.
           03 AZU00000034 PIC X(8) VALUE 'EIBSYNRB'.
           03 AZU00000036 PIC X(8) VALUE 'EIBNODAT'.
           03 AZU00000038 PIC X(7) VALUE 'EIBRESP'.
           03 AZU0000003A PIC X(8) VALUE 'EIBRESP2'.
           03 AZU0000003C PIC X(8) VALUE 'EIBRLDBK'.
       01  AZ-COMPARE-WORK-ITEMS.
           03 AZU00000001 PIC X(8) OCCURS 2.
           03 AZU00000003 PIC X(8) OCCURS 2.
           03 AZU00000005 PIC X(8) OCCURS 2.
           03 AZU00000007 PIC X(8) OCCURS 2.
           03 AZU00000009 PIC X(8) OCCURS 2.
           03 AZU0000000B PIC X(4) OCCURS 2.
           03 AZU0000000D PIC X(4) OCCURS 2.
           03 AZU0000000F PIC X(4) OCCURS 2.
           03 AZU00000011 PIC X(2) OCCURS 2.
           03 AZU00000013 PIC X(4) OCCURS 2.
           03 AZU00000015 PIC X(12) OCCURS 2.
           03 AZU00000017 PIC X(16) OCCURS 2.
           03 AZU00000019 PIC X(16) OCCURS 2.
           03 AZU0000001B PIC X(16) OCCURS 2.
           03 AZU0000001D PIC X(2) OCCURS 2.
           03 AZU0000001F PIC X(2) OCCURS 2.
           03 AZU00000021 PIC X(2) OCCURS 2.
           03 AZU00000023 PIC X(2) OCCURS 2.
           03 AZU00000025 PIC X(2) OCCURS 2.
           03 AZU00000027 PIC X(2) OCCURS 2.
           03 AZU00000029 PIC X(2) OCCURS 2.
           03 AZU0000002B PIC X(2) OCCURS 2.
           03 AZU0000002D PIC X(2) OCCURS 2.
           03 AZU0000002F PIC X(2) OCCURS 2.
           03 AZU00000031 PIC X(2) OCCURS 2.
           03 AZU00000033 PIC X(8) OCCURS 2.
           03 AZU00000035 PIC X(2) OCCURS 2.
           03 AZU00000037 PIC X(2) OCCURS 2.
           03 AZU00000039 PIC X(8) OCCURS 2.
           03 AZU0000003B PIC X(8) OCCURS 2.
           03 AZU0000003D PIC X(2) OCCURS 2.
       01 AZ-CONVERT.
         03 AZ-CONVERT-HEXIN  PIC X(1).
         03 AZ-CONVERT-HEXVAL PIC X(2).
         03 AZ-HEXSTR PIC X(16) VALUE "0123456789ABCDEF".
         03 AZ-DEC  PIC S9(4) COMP VALUE 0.
         03 FILLER REDEFINES AZ-DEC.
           05 FILLER PIC X.
           05 AZ-DECBYTE PIC X.
         03 AZ-I PIC S9(8) COMP.
         03 AZ-J PIC S9(8) COMP.
         03 AZ-K PIC S9(8) COMP.
         03 AZ-Q PIC S9(8) COMP.
         03 AZ-R PIC S9(8) COMP.
         03 AZ-Q1 PIC S9(8) COMP.
         03 AZ-R1 PIC S9(8) COMP.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 AZ-COMPARE-ITEM-NAME      PIC X(1000).
       01 AZ-COMPARE-ITEM-VALUE     PIC X(254).
       01 AZ-COMPARE-ITEM-EXP-VALUE PIC X(254).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       01  Dfheiblk.
             02 EIBTIME PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBTIME-AZ REDEFINES EIBTIME.
             03 PIC X(4).
             02 EIBDATE PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBDATE-AZ REDEFINES EIBDATE.
             03 PIC X(4).
             02 EIBTRNID PIC X(4).
             02 EIBTASKN PIC S9(7) USAGE PACKED-DECIMAL.
             02 EIBTASKN-AZ REDEFINES EIBTASKN.
             03 PIC X(4).
             02 EIBTRMID PIC X(4).
             02 DFHEIGDI PIC S9(4) USAGE COMP-5.
             02 EIBCPOSN PIC S9(4) USAGE COMP-5.
             02 EIBCALEN PIC S9(4) USAGE COMP-5.
             02 EIBAID PIC X(1).
             02 EIBFN PIC X(2).
             02 EIBRCODE PIC X(6).
             02 EIBDS PIC X(8).
             02 EIBREQID PIC X(8).
             02 EIBRSRCE PIC X(8).
             02 EIBSYNC PIC X.
             02 EIBFREE PIC X.
             02 EIBRECV PIC X.
             02 EIBSEND PIC X.
             02 EIBATT PIC X.
             02 EIBEOC PIC X.
             02 EIBFMH PIC X.
             02 EIBCOMPL PIC X(1).
             02 EIBSIG PIC X(1).
             02 EIBCONF PIC X(1).
             02 EIBERR PIC X(1).
             02 EIBERRCD PIC X(4).
             02 EIBSYNRB PIC X.
             02 EIBNODAT PIC X.
             02 EIBRESP PIC S9(8) USAGE BINARY.
             02 EIBRESP2 PIC S9(8) USAGE BINARY.
             02 EIBRLDBK PIC X(1).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_0E08_INQCUST.
           ENTRY 'CICS_INPT_0E08_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK Dfheiblk AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E08_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS RETURN
           IF ARG0-1 = X'0E08'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS RETURN L=' AZ-LINE-NUM
               MOVE 3 TO AZ-GRP-INDEX
               MOVE 0 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-OT(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM O0E081-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS RETURN
           IF ARG0-1 = X'0E08'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS RETURN L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_0E08_INQCUST.
           ENTRY 'CICS_OUTP_0E08_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK Dfheiblk AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E08_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS RETURN
           IF ARG0-1 = X'0E08'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS RETURN L=' AZ-LINE-NUM
               MOVE 3 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM I0E081-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS RETURN
           IF ARG0-1 = X'0E08'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS RETURN L=' AZ-LINE-NUM
               MOVE 14 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(2)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG22-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       O0E081-TEST2.
           INITIALIZE AZ-COMPARE-WORK-ITEMS
           IF AZ-RECORD-COUNT-OT(1) = 0
             NEXT SENTENCE
           ELSE
             NEXT SENTENCE
           .
       I0E081-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
           MOVE X'0093000C0126307CD6C4C3E20019444CF0F0F0F1000000000000C5
      -    'D9C540404040404040404040404040404040404040404040404040404040
      -    '40404040404040404040404040404040404040000000000000000040' TO
            Dfheiblk
           ELSE
             NEXT SENTENCE
           .
       IG22-TEST2.
           IF AZ-RECORD-COUNT-IN(2) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(2) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       CONVERT.
           MOVE AZ-CONVERT-HEXIN TO AZ-DECBYTE
           DIVIDE AZ-DEC BY 16 GIVING AZ-Q REMAINDER AZ-R
           COMPUTE AZ-Q1 = AZ-Q + 1
           COMPUTE AZ-R1 = AZ-R + 1
           MOVE AZ-HEXSTR(AZ-Q1:1) TO AZ-CONVERT-HEXVAL(1:1)
           MOVE AZ-HEXSTR(AZ-R1:1) TO AZ-CONVERT-HEXVAL(2:1)
           EXIT.
       THROW-ASSERTION.
           SET ADDRESS OF AZ-COMPARE-ITEM-NAME TO
           AZ-COMPARE-ITEM-NAME-PTR.
           SET ADDRESS OF AZ-COMPARE-ITEM-VALUE TO
           AZ-COMPARE-ITEM-VALUE-PTR.
           SET ADDRESS OF AZ-COMPARE-ITEM-EXP-VALUE TO
           AZ-COMPARE-ITEM-EXP-VALUE-PTR.
      *    DISPLAY ERROR MESSAGE AND ENDS TEST
           DISPLAY 'AZU0000I *******************************************
      -    '*************************************'
           DISPLAY 'AZU2001W THE TEST "' AZ-TEST(1:AZ-TEST-LEN) '" FAILE
      -    'D DUE TO AN ASSERTION.'
           DISPLAY 'AZU1101I ' MESSAGE-TXT OF BZ-ASSERT(1:MESSAGE-LEN
           OF BZ-ASSERT)
           DISPLAY 'AZU0000I  DATA ITEM NAME : '
           AZ-COMPARE-ITEM-NAME(1:AZ-COMPARE-ITEM-NAME-LEN)
           DISPLAY 'AZU0000I   VALUE         : '
           AZ-COMPARE-ITEM-VALUE(1:AZ-COMPARE-ITEM-VALUE-LEN)
           DISPLAY 'AZU0000I   EXPECTED VALUE: '
           AZ-COMPARE-ITEM-EXP-VALUE(1:AZ-COMPARE-ITEM-EXP-VALUE-LEN)
           DISPLAY 'AZU0000I *******************************************
      -    '*************************************'
           CALL BZUASSRT USING BZ-P1 BZ-P2 BZ-P3 BZ-ASSERT
           MOVE 1 TO TRACE-LEN OF BZ-TRACE
           MOVE 1 TO AZ-ITEM-NAME-S
           PERFORM UNTIL AZ-ITEM-NAME-S > AZ-COMPARE-ITEM-NAME-LEN
             MOVE 206 TO AZ-ITEM-NAME-LEN
             IF AZ-ITEM-NAME-S + 206 > AZ-COMPARE-ITEM-NAME-LEN THEN
               MOVE AZ-COMPARE-ITEM-NAME-LEN TO AZ-ITEM-NAME-LEN
               SUBTRACT AZ-ITEM-NAME-S FROM AZ-ITEM-NAME-LEN
               ADD 1 TO AZ-ITEM-NAME-LEN
             END-IF
             STRING 'ITEM NAME='
             AZ-COMPARE-ITEM-NAME(AZ-ITEM-NAME-S:AZ-ITEM-NAME-LEN)
               DELIMITED BY SIZE INTO TRACE-TXT OF BZ-TRACE
               WITH POINTER TRACE-LEN OF BZ-TRACE
             END-STRING
             SUBTRACT 1 FROM TRACE-LEN OF BZ-TRACE
             SET AZ-TRACE-PTR TO ADDRESS OF TRACE-TXT OF BZ-TRACE
             CALL BZUTRACE USING BZ-TRACE
             MOVE 1 TO TRACE-LEN OF BZ-TRACE
             ADD AZ-ITEM-NAME-LEN TO AZ-ITEM-NAME-S
           END-PERFORM
           STRING 'VALUE   ='
           AZ-COMPARE-ITEM-VALUE(1:AZ-COMPARE-ITEM-VALUE-LEN)
               DELIMITED BY SIZE INTO TRACE-TXT OF BZ-TRACE
               WITH POINTER TRACE-LEN OF BZ-TRACE
             END-STRING
           SUBTRACT 1 FROM TRACE-LEN OF BZ-TRACE
           CALL BZUTRACE USING BZ-TRACE
           MOVE 1 TO TRACE-LEN OF BZ-TRACE
           STRING 'EXPECTED='
           AZ-COMPARE-ITEM-EXP-VALUE(1:AZ-COMPARE-ITEM-EXP-VALUE-LEN)
               DELIMITED BY SIZE INTO TRACE-TXT OF BZ-TRACE
               WITH POINTER TRACE-LEN OF BZ-TRACE
             END-STRING
           SUBTRACT 1 FROM TRACE-LEN OF BZ-TRACE
           CALL BZUTRACE USING BZ-TRACE
           EXIT.
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_0E08_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_0E08_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS ASSIGN                          |
      *|    FUNCTION CODE: 0208                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_0208_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 5 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 5 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_0208_INQCUST.
           ENTRY 'CICS_INPT_0208_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0208_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_0208_INQCUST.
           ENTRY 'CICS_OUTP_0208_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0208_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
               MOVE 4 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG11-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
               MOVE 5 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(2)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG22-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
               MOVE 8 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(3)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG33-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
               MOVE 10 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(4)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG44-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS ASSIGN
           IF ARG0-1 = X'0208'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASSIGN L=' AZ-LINE-NUM
               MOVE 11 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(5)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG55-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       IG11-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG22-TEST2.
           IF AZ-RECORD-COUNT-IN(2) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(2) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG33-TEST2.
           IF AZ-RECORD-COUNT-IN(3) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(3) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG44-TEST2.
           IF AZ-RECORD-COUNT-IN(4) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(4) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG55-TEST2.
           IF AZ-RECORD-COUNT-IN(5) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(5) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_0208_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_0208_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS LINK PROGRAM                    |
      *|    FUNCTION CODE: 0E02                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_0E02_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 2 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 2 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_0E02_INQCUST.
           ENTRY 'CICS_INPT_0E02_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E02_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS LINK PROGRAM
           IF ARG0-1 = X'0E02'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS LINK PROGRAM L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS LINK PROGRAM
           IF ARG0-1 = X'0E02'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS LINK PROGRAM L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_0E02_INQCUST.
           ENTRY 'CICS_OUTP_0E02_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E02_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS LINK PROGRAM
           IF ARG0-1 = X'0E02'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS LINK PROGRAM L=' AZ-LINE-NUM
               MOVE 6 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG11-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS LINK PROGRAM
           IF ARG0-1 = X'0E02'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS LINK PROGRAM L=' AZ-LINE-NUM
               MOVE 12 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(2)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG22-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       IG11-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG22-TEST2.
           IF AZ-RECORD-COUNT-IN(2) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(2) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_0E02_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_0E02_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS ABEND                           |
      *|    FUNCTION CODE: 0E0C                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_0E0C_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 3 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 3 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_0E0C_INQCUST.
           ENTRY 'CICS_INPT_0E0C_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E0C_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS ABEND
           IF ARG0-1 = X'0E0C'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ABEND L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS ABEND
           IF ARG0-1 = X'0E0C'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ABEND L=' AZ-LINE-NUM
           END-IF.
      * EXEC CICS ABEND
           IF ARG0-1 = X'0E0C'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ABEND L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_0E0C_INQCUST.
           ENTRY 'CICS_OUTP_0E0C_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_0E0C_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS ABEND
           IF ARG0-1 = X'0E0C'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ABEND L=' AZ-LINE-NUM
               MOVE 7 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG11-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS ABEND
           IF ARG0-1 = X'0E0C'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ABEND L=' AZ-LINE-NUM
               MOVE 13 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(2)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG22-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
      * EXEC CICS ABEND
           IF ARG0-1 = X'0E0C'
               MOVE 3 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ABEND L=' AZ-LINE-NUM
               MOVE 15 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(3)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG33-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       IG11-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG22-TEST2.
           IF AZ-RECORD-COUNT-IN(2) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(2) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       IG33-TEST2.
           IF AZ-RECORD-COUNT-IN(3) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(3) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_0E0C_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_0E0C_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS SYNCPOINT                       |
      *|    FUNCTION CODE: 1602                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_1602_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_1602_INQCUST.
           ENTRY 'CICS_INPT_1602_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_1602_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS SYNCPOINT
           IF ARG0-1 = X'1602'
               MOVE 7 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS SYNCPOINT L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_1602_INQCUST.
           ENTRY 'CICS_OUTP_1602_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_1602_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS SYNCPOINT
           IF ARG0-1 = X'1602'
               MOVE 7 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS SYNCPOINT L=' AZ-LINE-NUM
               MOVE 9 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG11-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       IG11-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_1602_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_1602_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS ASKTIME                         |
      *|    FUNCTION CODE: 1002                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_1002_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_1002_INQCUST.
           ENTRY 'CICS_INPT_1002_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_1002_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS ASKTIME
           IF ARG0-1 = X'1002'
               MOVE 7 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASKTIME L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_1002_INQCUST.
           ENTRY 'CICS_OUTP_1002_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_1002_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS ASKTIME
           IF ARG0-1 = X'1002'
               MOVE 7 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS ASKTIME L=' AZ-LINE-NUM
               MOVE 16 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG11-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       IG11-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_1002_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_1002_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC CICS FORMATTIME                      |
      *|    FUNCTION CODE: 4A04                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'CICS_4A04_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 10.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'CICS HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN       PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-OPT-MASK-DATA2  PIC X(2).
       01 AZ-OPT-MASK-DATA9  PIC X(9).
       01 AZ-OPT-MASK-DATA11 PIC X(11).
       01 AZ-OPT-MASK-DATA19 PIC X(19).
       01 AZ-OPT-BYTECOUNT   PIC S9(8) COMP.
       01 AZ-OPT-RC          PIC 9(1) VALUE 0.
       01 AZ-OPT-COMMASK.
         03  AZ-OPT-COMMASK-DATA2  PIC X(2) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA9  PIC X(9) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA11 PIC X(11) OCCURS 1.
         03  AZ-OPT-COMMASK-DATA19 PIC X(19) OCCURS 1.
       01 AZ-LINE-BYTE      PIC S9(2) COMP.
       01 AZ-LINE-NUM       PIC 9(5).
       01 AZ-LINE-NUM-R   REDEFINES AZ-LINE-NUM.
         03 AZ-LINE-NUM-RD  PIC 9(1) OCCURS 5.
       01 AZ-LINE-I         PIC S9(8) COMP.
       01 AZ-LINE-J         PIC S9(8) COMP.
       01 AZ-RC-WORK        PIC S9(4) USAGE BINARY.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
       01 AZ-TEST                   PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-MODX                   PIC X(4).
       01 AZ-DFHEIBLK.
         03 FILLER                  PIC X(76).
         03 EIBRESP                 PIC S9(8) USAGE BINARY.
         03 EIBRESP2                PIC S9(8) USAGE BINARY.
         03 FILLER                  PIC X(1).
       01 AZ-DFHCOMMAREA.
         03 FILLER                  PIC X(1).
       01 ARG0.
         03 ARG0-1        PIC X(2).
         03 ARG0-A        PIC X(28).
         03 ARG0-B REDEFINES ARG0-A.
           05 ARG0-2      PIC X(9).
           05 FILLER      PIC X(19).
         03 ARG0-C REDEFINES ARG0-A.
           05 FILLER      PIC X(6).
           05 ARG0-D.
             07 ARG0-3    PIC 9(1) OCCURS 22.
       01 AZ-CICS-TARGET-NAME-DEF4 PIC X(4).
       01 AZ-CICS-TARGET-NAME-DEF7 PIC X(7).
       01 AZ-CICS-TARGET-NAME-DEF8 PIC X(8).
       01 AZ-CICS-TARGET-NAME-DEF16 PIC X(16).
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * CICS_INPT_4A04_INQCUST.
           ENTRY 'CICS_INPT_4A04_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_4A04_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS FORMATTIME
           IF ARG0-1 = X'4A04'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS FORMATTIME L=' AZ-LINE-NUM
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * CICS_OUTP_4A04_INQCUST.
           ENTRY 'CICS_OUTP_4A04_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-DFHEIBLK AZ-DFHCOMMAREA ARG0.
           DISPLAY 'AZU0000I CICS_4A04_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC CICS FORMATTIME
           IF ARG0-1 = X'4A04'
               MOVE 16 TO AZ-LINE-BYTE
               PERFORM GETLINENUM
               DISPLAY 'AZU0000I EXEC CICS FORMATTIME L=' AZ-LINE-NUM
               MOVE 17 TO AZ-GRP-INDEX
               MOVE 1 TO AZ-FLAG-IN
               MOVE RETURN-CODE TO AZ-RC-WORK
               CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
                 AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
               SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
               MOVE AZ-RC-WORK TO RETURN-CODE
               ADD 1 TO AZ-WK-RECORD-COUNT
               MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
               EVALUATE AZ-TEST(1:AZ-TEST-LEN)
                 WHEN SPACE
                   CONTINUE
                 WHEN 'TEST2'
                   PERFORM IG11-TEST2
                   CONTINUE
                 WHEN OTHER
                   CONTINUE
                 END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       IG11-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE 0 TO EIBRESP
             MOVE 0 TO EIBRESP2
           ELSE
             NEXT SENTENCE
           .
       GETLINENUM.
           MOVE 1 TO AZ-LINE-J
           PERFORM VARYING AZ-LINE-I FROM AZ-LINE-BYTE BY 1
             UNTIL AZ-LINE-I > AZ-LINE-BYTE + 4
             MOVE ARG0-3(AZ-LINE-I) TO AZ-LINE-NUM-RD(AZ-LINE-J)
             ADD 1 TO AZ-LINE-J
           END-PERFORM
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I CICS_4A04_INQCUST END.'
           EXIT.
       END PROGRAM 'CICS_4A04_INQCUST'.
      *+---------------------------------------------------------------+
      *| UNIT TEST FOR Z/OS: EXEC SQL SELECT_INTO                      |
      *|    FUNCTION CODE: 00E7                                        |
      *| TEST CASE VERSION: 203                                        |
      *+---------------------------------------------------------------+
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'DB2_00E7_INQCUST'.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  BZUASSRT          PIC  X(08)        VALUE 'BZUASSRT'.
       01  BZ-ASSERT.
           03 MESSAGE-LEN    PIC S9(04) COMP-4 VALUE 9.
           03 MESSAGE-TXT    PIC  X(254)       VALUE 'DB2 HELLO'.
       01  BZ-P1             PIC S9(09) COMP-4 VALUE 4.
       01  BZ-P2             PIC S9(09) COMP-4 VALUE 2001.
       01  BZ-P3             PIC  X(03)        VALUE 'AZU'.
      *
       01 BZ-TRACE.
         03 TRACE-LEN       PIC S9(4) COMP-4 VALUE 5.
         03 TRACE-TXT       PIC X(254) VALUE 'TRACE'.
       01 BZUTRACE          PIC X(8) VALUE 'BZUTRACE'.
       01 AZ-TRACE-PTR      POINTER.
       01 AZ-TEST-LEN        PIC S9(8) COMP.
       01 AZ-RECORD.
         03 AZ-RECORD-COUNT-OT OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-RECORD-COUNT-IN OCCURS 1 PIC 9(5) COMP-5 VALUE 0.
         03 AZ-OUT-PARM-NUM  PIC 9(8).
         03 AZ-IN-PARM-NUM   PIC 9(8).
         03 AZ-STMT-NUM      PIC 9(9).
       01 AZ-GRP-INDEX       PIC 9(8).
       01 AZ-FLAG-IN         PIC 9(1).
       01 AZ-RECORD-PTR      POINTER.
       01 AZ-RC-WORK         PIC S9(4) USAGE BINARY.
       01 AZ-COMPARE.
         03 AZ-COMPARE-ITEM-NAME-PTR POINTER.
         03 AZ-COMPARE-ITEM-NAME-LEN PIC S9(9) COMP-5.
         03 AZ-COMPARE-ITEM-VALUE-PTR POINTER.
         03 AZ-COMPARE-ITEM-VALUE-LEN PIC S9(9) COMP-5.
         03 AZ-COMPARE-ITEM-EXP-VALUE-PTR POINTER.
         03 AZ-COMPARE-ITEM-EXP-VALUE-LEN PIC S9(9) COMP-5.
         03 AZ-ITEM-NAME-S            PIC S9(8) COMP.
         03 AZ-ITEM-NAME-LEN          PIC S9(8) COMP.
       01  AZ-TEST-EXPECTED-DATA-VALUE.
           03 AZU00000000 PIC X(6) VALUE '987654'.
           03 AZU00000001 PIC X(10) VALUE '0000000042'.
       01  AZ-TEST-INPUT-DATA-VALUE.
           03 AZU00000002 PIC X(6) VALUE '987654'.
           03 AZU00000003 PIC X(10) VALUE '0000000042'.
       01  AZ-SQLCA.
           03 AZS00000000 PIC X(136) VALUE
           X'40404040404040400000008800000064000000000000000000000000000
      -    '000000000000000000000000000000000000000000000000000000000000
      -    '000000000000000000000000000000000000000000000000000000000000
      -    '000000000000000000000000000000000000000000000000000000000000
      -    '000000000000000000000000000000000'.
       LOCAL-STORAGE SECTION.
       01 AZ-HOSTVAR-PTR     POINTER.
       01 AZ-HOSTVAR-PTR-ADDR
           REDEFINES AZ-HOSTVAR-PTR PIC 9(9) COMP-5.
       01  AZ-COMPARE-ITEM-NAMES.
           03 AZU00000004 PIC X(20) VALUE 'HV-CUSTOMER-SORTCODE'.
           03 AZU00000006 PIC X(18) VALUE 'HV-CUSTOMER-NUMBER'.
       01  AZ-COMPARE-WORK-ITEMS.
           03 AZU00000005 PIC X(6) OCCURS 2.
           03 AZU00000007 PIC X(10) OCCURS 2.
       LINKAGE SECTION.
       01 AZ-TEST            PIC X(80).
       01 AZ-INFO-BLOCK.
          COPY EQAITERC.
       01 AZ-APLIST.
          COPY EQADB2CP.
       01 AZ-WK-RECORD-COUNT PIC 9(5) COMP-5.
       01 AZ-COMPARE-ITEM-NAME      PIC X(1000).
       01 AZ-COMPARE-ITEM-VALUE     PIC X(254).
       01 AZ-COMPARE-ITEM-EXP-VALUE PIC X(254).
       01 ARGO1.
          COPY EQADB2CV.
       01 ARGO2.
          COPY EQADB2CV.
       01 ARGI1          .
          COPY EQADB2CV.
       01 ARGI2          .
          COPY EQADB2CV.
       01 ARGI3          .
          COPY EQADB2CV.
       01 ARGI4          .
          COPY EQADB2CV.
       01 ARGI5          .
          COPY EQADB2CV.
       01 ARGI6          .
          COPY EQADB2CV.
       01 ARGI7          .
          COPY EQADB2CV.
       01 ARGI8          .
          COPY EQADB2CV.
       01 ARGI9          .
          COPY EQADB2CV.
       01 ARGI10         .
          COPY EQADB2CV.
       01 ARGI11         .
          COPY EQADB2CV.
       01 ARGI12         .
          COPY EQADB2CV.
       01 ARGI13         .
          COPY EQADB2CV.
       01 ARGI14         .
          COPY EQADB2CV.
       01 ARGI15         .
          COPY EQADB2CV.
       01 ARGI16         .
          COPY EQADB2CV.
       01 ARGI17         .
          COPY EQADB2CV.
       01  AZU00000008.
           03 HV-CUSTOMER-SORTCODE PIC X(6).
       01  AZU00000009.
           03 HV-CUSTOMER-NUMBER PIC X(10).
       01  AZU0000000A.
           03 HV-CUSTOMER-EYECATCHER PIC X(4).
       01  AZU0000000B.
           03 HV-CUSTOMER-SORTCODE PIC X(6).
       01  AZU0000000C.
           03 HV-CUSTOMER-NUMBER PIC X(10).
       01  AZU0000000D.
           03 HV-CUSTOMER-TITLE PIC X(10).
       01  AZU0000000E.
           03 HV-CUSTOMER-FIRST-NAME PIC X(50).
       01  AZU0000000F.
           03 HV-CUSTOMER-LAST-NAME PIC X(50).
       01  AZU00000010.
           03 HV-CUSTOMER-DOB PIC S9(9) USAGE BINARY.
       01  AZU00000011.
           03 HV-CUSTOMER-PHONE PIC X(20).
       01  AZU00000012.
           03 HV-CUSTOMER-ADDR-LINE1 PIC X(50).
       01  AZU00000013.
           03 HV-CUSTOMER-ADDR-LINE2 PIC X(50).
       01  AZU00000014.
           03 HV-CUSTOMER-CITY PIC X(50).
       01  AZU00000015.
           03 HV-CUSTOMER-POSTCODE PIC X(10).
       01  AZU00000016.
           03 HV-CUSTOMER-COUNTRY PIC X(50).
       01  AZU00000017.
           03 HV-CUSTOMER-STATUS PIC X(10).
       01  AZU00000018.
           03 HV-CUSTOMER-CREATE-DATE PIC S9(9) USAGE BINARY.
       01  AZU00000019.
           03 HV-CUSTOMER-CREDIT-SCORE PIC S9(4) USAGE BINARY.
       01  AZU0000001A.
           03 HV-CUSTOMER-CS-REVIEW-DATE PIC S9(9) USAGE BINARY.
       01  SQLCA.
           05 SQLCAID PIC X(8).
           05 SQLCABC PIC S9(9) USAGE COMP-5.
           05 SQLCODE PIC S9(9) USAGE COMP-5.
           05 SQLERRM.
              49 SQLERRML PIC S9(4) USAGE COMP-5.
              49 SQLERRMC PIC X(70).
           05 SQLERRP PIC X(8).
           05 SQLERRD OCCURS 6 TIMES PIC S9(9) USAGE COMP-5.
           05 SQLWARN.
              10 SQLWARN0 PIC X.
              10 SQLWARN1 PIC X.
              10 SQLWARN2 PIC X.
              10 SQLWARN3 PIC X.
              10 SQLWARN4 PIC X.
              10 SQLWARN5 PIC X.
              10 SQLWARN6 PIC X.
              10 SQLWARN7 PIC X.
           05 SQLEXT.
              10 SQLWARN8 PIC X.
              10 SQLWARN9 PIC X.
              10 SQLWARNA PIC X.
              10 SQLSTATE PIC X(5).
       01 AZ-SQLDA.
          COPY EQADB2CA.
       PROCEDURE DIVISION.
      * CHECK OUTPUT VALUE
      * DB2_INPT_00E7_INQCUST.
           ENTRY 'DB2_INPT_00E7_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-APLIST ARGO1 ARGO2.
           DISPLAY 'AZU0000I DB2_00E7_INQCUST CHECK VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE SQL-STMT-NUM OF AZ-APLIST TO AZ-STMT-NUM
           SET ADDRESS OF AZ-SQLDA TO SQL-VPARMPTR
           MOVE SQLDA-NUM OF AZ-SQLDA TO AZ-OUT-PARM-NUM
           SET ADDRESS OF AZ-SQLDA TO SQL-APARMPTR
           MOVE SQLDA-NUM OF AZ-SQLDA TO AZ-IN-PARM-NUM
           SET ADDRESS OF SQLCA TO SQL-CODEPTR OF AZ-APLIST
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC SQL SELECT_INTO : OUT=2 IN=17
           IF AZ-OUT-PARM-NUM = 2 AND
              AZ-IN-PARM-NUM = 17 THEN
             DISPLAY 'AZU0000I EXEC SQL SELECT_INTO'
              ' : OUT=' 2 ' IN=' 17
              ' L=' AZ-STMT-NUM
             MOVE SQL-AVAR-ADDR OF ARGO1 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000008
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGO2 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000009
             TO AZ-HOSTVAR-PTR
             MOVE 2 TO AZ-GRP-INDEX
             MOVE 0 TO AZ-FLAG-IN
             MOVE RETURN-CODE TO AZ-RC-WORK
             CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
               AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
             SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
             MOVE AZ-RC-WORK TO RETURN-CODE
             ADD 1 TO AZ-WK-RECORD-COUNT
             MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-OT(1)
             EVALUATE AZ-TEST(1:AZ-TEST-LEN)
               WHEN SPACE
                 CONTINUE
               WHEN 'TEST2'
                 PERFORM O00E70-TEST2
                 CONTINUE
               WHEN OTHER
                 CONTINUE
             END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
      * SET INPUT VALUE
      * DB2_OUTP_00E7_INQCUST.
           ENTRY 'DB2_OUTP_00E7_INQCUST' USING AZ-TEST
           AZ-INFO-BLOCK AZ-APLIST ARGI1 ARGI2 ARGI3 ARGI4 ARGI5 ARGI6
           ARGI7 ARGI8 ARGI9 ARGI10 ARGI11 ARGI12 ARGI13 ARGI14
           ARGI15 ARGI16 ARGI17.
           DISPLAY 'AZU0000I DB2_00E7_INQCUST INPUT VALUES...'
           MOVE 0 TO RETURN-CODE.
           MOVE SQL-STMT-NUM OF AZ-APLIST TO AZ-STMT-NUM
           SET ADDRESS OF AZ-SQLDA TO SQL-VPARMPTR
           MOVE SQLDA-NUM OF AZ-SQLDA TO AZ-OUT-PARM-NUM
           SET ADDRESS OF AZ-SQLDA TO SQL-APARMPTR
           MOVE SQLDA-NUM OF AZ-SQLDA TO AZ-IN-PARM-NUM
           SET ADDRESS OF SQLCA TO SQL-CODEPTR OF AZ-APLIST
           MOVE 0 TO AZ-TEST-LEN.
           INSPECT AZ-TEST TALLYING AZ-TEST-LEN FOR
           CHARACTERS BEFORE INITIAL SPACE.
      * EXEC SQL SELECT_INTO : OUT=2 IN=17
           IF AZ-OUT-PARM-NUM = 2 AND
              AZ-IN-PARM-NUM = 17 THEN
             DISPLAY 'AZU0000I EXEC SQL SELECT_INTO'
              ' : OUT=' 2 ' IN=' 17
              ' L=' AZ-STMT-NUM
             MOVE SQL-AVAR-ADDR OF ARGI1 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000000A
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI2 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000000B
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI3 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000000C
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI4 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000000D
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI5 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000000E
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI6 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000000F
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI7 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000010
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI8 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000011
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI9 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000012
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI10 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000013
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI11 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000014
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI12 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000015
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI13 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000016
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI14 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000017
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI15 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000018
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI16 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU00000019
             TO AZ-HOSTVAR-PTR
             MOVE SQL-AVAR-ADDR OF ARGI17 TO AZ-HOSTVAR-PTR-ADDR
             SET ADDRESS OF AZU0000001A
             TO AZ-HOSTVAR-PTR
             MOVE 2 TO AZ-GRP-INDEX
             MOVE 1 TO AZ-FLAG-IN
             MOVE RETURN-CODE TO AZ-RC-WORK
             CALL 'GTMEMRC' USING TC-WORK-AREA OF AZ-INFO-BLOCK
               AZ-GRP-INDEX AZ-FLAG-IN AZ-RECORD-PTR
             SET ADDRESS OF AZ-WK-RECORD-COUNT TO AZ-RECORD-PTR
             MOVE AZ-RC-WORK TO RETURN-CODE
             ADD 1 TO AZ-WK-RECORD-COUNT
             MOVE AZ-WK-RECORD-COUNT TO AZ-RECORD-COUNT-IN(1)
             EVALUATE AZ-TEST(1:AZ-TEST-LEN)
               WHEN SPACE
                 CONTINUE
               WHEN 'TEST2'
                 PERFORM I00E70-TEST2
                 CONTINUE
               WHEN OTHER
                 CONTINUE
             END-EVALUATE
           END-IF.
           PERFORM TEARDOWN.
           GOBACK.
       O00E70-TEST2.
           INITIALIZE AZ-COMPARE-WORK-ITEMS
           IF AZ-RECORD-COUNT-OT(1) = 0
             NEXT SENTENCE
           ELSE
             NEXT SENTENCE
           .
       I00E70-TEST2.
           IF AZ-RECORD-COUNT-IN(1) = 0
             NEXT SENTENCE
           ELSE IF AZ-RECORD-COUNT-IN(1) = 1
             MOVE AZS00000000 TO SQLCA
           MOVE AZU00000002 TO HV-CUSTOMER-SORTCODE OF AZU0000000B
           MOVE 100 TO SQLCODE
           MOVE AZU00000003 TO HV-CUSTOMER-NUMBER OF AZU0000000C
           ELSE
             NEXT SENTENCE
           .
       THROW-ASSERTION.
           SET ADDRESS OF AZ-COMPARE-ITEM-NAME TO
           AZ-COMPARE-ITEM-NAME-PTR.
           SET ADDRESS OF AZ-COMPARE-ITEM-VALUE TO
           AZ-COMPARE-ITEM-VALUE-PTR.
           SET ADDRESS OF AZ-COMPARE-ITEM-EXP-VALUE TO
           AZ-COMPARE-ITEM-EXP-VALUE-PTR.
      *    DISPLAY ERROR MESSAGE AND ENDS TEST
           DISPLAY 'AZU0000I *******************************************
      -    '*************************************'
           DISPLAY 'AZU2001W THE TEST "' AZ-TEST(1:AZ-TEST-LEN) '" FAILE
      -    'D DUE TO AN ASSERTION.'
           DISPLAY 'AZU1101I ' MESSAGE-TXT OF BZ-ASSERT(1:MESSAGE-LEN
           OF BZ-ASSERT)
           DISPLAY 'AZU0000I  DATA ITEM NAME : '
           AZ-COMPARE-ITEM-NAME(1:AZ-COMPARE-ITEM-NAME-LEN)
           DISPLAY 'AZU0000I   VALUE         : '
           AZ-COMPARE-ITEM-VALUE(1:AZ-COMPARE-ITEM-VALUE-LEN)
           DISPLAY 'AZU0000I   EXPECTED VALUE: '
           AZ-COMPARE-ITEM-EXP-VALUE(1:AZ-COMPARE-ITEM-EXP-VALUE-LEN)
           DISPLAY 'AZU0000I *******************************************
      -    '*************************************'
           CALL BZUASSRT USING BZ-P1 BZ-P2 BZ-P3 BZ-ASSERT
           MOVE 1 TO TRACE-LEN OF BZ-TRACE
           MOVE 1 TO AZ-ITEM-NAME-S
           PERFORM UNTIL AZ-ITEM-NAME-S > AZ-COMPARE-ITEM-NAME-LEN
             MOVE 206 TO AZ-ITEM-NAME-LEN
             IF AZ-ITEM-NAME-S + 206 > AZ-COMPARE-ITEM-NAME-LEN THEN
               MOVE AZ-COMPARE-ITEM-NAME-LEN TO AZ-ITEM-NAME-LEN
               SUBTRACT AZ-ITEM-NAME-S FROM AZ-ITEM-NAME-LEN
               ADD 1 TO AZ-ITEM-NAME-LEN
             END-IF
             STRING 'ITEM NAME='
             AZ-COMPARE-ITEM-NAME(AZ-ITEM-NAME-S:AZ-ITEM-NAME-LEN)
               DELIMITED BY SIZE INTO TRACE-TXT OF BZ-TRACE
               WITH POINTER TRACE-LEN OF BZ-TRACE
             END-STRING
             SUBTRACT 1 FROM TRACE-LEN OF BZ-TRACE
             SET AZ-TRACE-PTR TO ADDRESS OF TRACE-TXT OF BZ-TRACE
             CALL BZUTRACE USING BZ-TRACE
             MOVE 1 TO TRACE-LEN OF BZ-TRACE
             ADD AZ-ITEM-NAME-LEN TO AZ-ITEM-NAME-S
           END-PERFORM
           STRING 'VALUE   ='
           AZ-COMPARE-ITEM-VALUE(1:AZ-COMPARE-ITEM-VALUE-LEN)
               DELIMITED BY SIZE INTO TRACE-TXT OF BZ-TRACE
               WITH POINTER TRACE-LEN OF BZ-TRACE
             END-STRING
           SUBTRACT 1 FROM TRACE-LEN OF BZ-TRACE
           CALL BZUTRACE USING BZ-TRACE
           MOVE 1 TO TRACE-LEN OF BZ-TRACE
           STRING 'EXPECTED='
           AZ-COMPARE-ITEM-EXP-VALUE(1:AZ-COMPARE-ITEM-EXP-VALUE-LEN)
               DELIMITED BY SIZE INTO TRACE-TXT OF BZ-TRACE
               WITH POINTER TRACE-LEN OF BZ-TRACE
             END-STRING
           SUBTRACT 1 FROM TRACE-LEN OF BZ-TRACE
           CALL BZUTRACE USING BZ-TRACE
           EXIT.
           EXIT.
       TEARDOWN.
           DISPLAY 'AZU0000I DB2_00E7_INQCUST END.'
           EXIT.
       END PROGRAM 'DB2_00E7_INQCUST'.
