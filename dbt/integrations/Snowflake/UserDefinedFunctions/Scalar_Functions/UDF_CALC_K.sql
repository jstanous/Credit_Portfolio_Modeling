/*------------------------------------------------------------------------------
Function: UDF_CALC_K
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Basel III IRB Capital Factor (K) to determine risk-weighted capital requirements.
  This is the Retail Form.
Notes:
  - Returns NUMBER(10,8).
  - Formula: K = LGD × RW.
  - LGD and RW are expected to be between 0 and 1.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION CREDIT_PORTFOLIO.UDF.UDF_CALC_K
      (LGD NUMBER(10,8)
      ,RW NUMBER(10,8)
      )
    RETURNS NUMBER(10,8)
    LANGUAGE SQL
    AS
    $$
    LGD * RW
    $$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.UDF_CALC_K(NUMBER(10,8), NUMBER(10,8))
     IS 'Gets the Retail Form of the Basel III IRB Capital Factor (K)';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT UDF_CALC_K(0.45, 0.12);  
-- Expected: 0.0540000000
-- Returned: 0.054000000000

SELECT UDF_CALC_K(0.50, 0.20);  
-- Expected: 0.1000000000
-- Returned: 0.100000000000

SELECT UDF_CALC_K(0.25, 0.08);  
-- Expected: 0.0200000000
-- Returned: 0.020000000000

SELECT UDF_CALC_K(0.90, 0.50);  
-- Expected: 0.4500000000
-- Returned: 0.450000000000
