--******************************************************************
--*
--*  Copyright IBM Corp. 2023
--*
--*  Loyalty Programme - CUSTOMER table schema extension
--*  Workstream A: Add LOYALTY_POINTS and LOYALTY_TIER columns
--*
--*  Execute during a low-traffic window.
--*  After execution, rebind ALL packages/plans that reference
--*  the CUSTOMER table:
--*    CRECUST, INQCUST, UPDCUST, DELCUS, BANKDATA,
--*    DBCRFUN, XFRFUN
--*
--******************************************************************

ALTER TABLE CUSTOMER
  ADD COLUMN LOYALTY_POINTS INTEGER,
  ADD COLUMN LOYALTY_TIER   CHAR(10);
