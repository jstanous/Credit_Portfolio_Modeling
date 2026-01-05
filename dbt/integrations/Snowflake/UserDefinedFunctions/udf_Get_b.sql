/*------------------------------------------------------------------------------
Function: UDF_GET_B
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Basel III IRB maturity sensitivity factor (b).
  Adjusts capital requirement scaling based on effective maturity (M).
Notes:
  - Returns NUMBER(10,8).
  - Formula: b(M) = min(1 + 0.05 × (M − 2.5), 1.5).
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION CREDIT_PORTFOLIO.UDF.UDF_GET_B
      (M NUMBER(10,8)
      )
    RETURNS NUMBER(10,8)
    LANGUAGE SQL
    AS 
    $$
        LEAST((1.00 + 0.05 * (M - 2.50)), 1.50)
    $$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.UDF_GET_B(NUMBER(10,8))
     IS 'Basel III IRB maturity sensitivity factor (b)';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT UDF_GET_B(20);
-- Expected: 1.5000000000
-- Returned: 1.5000000000

SELECT UDF_GET_B(10);
-- Expected: 1.3750000000
-- Returned: 1.3750000000

SELECT UDF_GET_B(5);
-- Expected: 1.1250000000
-- Returned: 1.1250000000

SELECT UDF_GET_B(2.5);
-- Expected: 1.0000000000
-- Returned: 1.0000000000

SELECT UDF_GET_B(1);
-- Expected: 0.9250000000
-- Returned: 0.9250000000