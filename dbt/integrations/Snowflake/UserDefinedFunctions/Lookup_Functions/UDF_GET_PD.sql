/*------------------------------------------------------------------------------
Function: UDF_GET_PD
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Probability of Default (PD): loan default probability based on customer's credit score at origination.
Notes:
  - Returns NUMBER(10,8).
  - Pulls PD values from CREDIT_PORTFOLIO.REF.PD based on credit subgrade.
  - If credit subgrade not found, returns 0.99999999 as sentinel/fallback.
  - PD values are expected to be between 0 and 1.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION UDF_GET_PD
      (input_subgrade VARCHAR(2)
      )
    RETURNS NUMBER(10,8)
    LANGUAGE SQL
    AS
    $$
    SELECT MIN(PD)
      FROM CREDIT_PORTFOLIO.REF.PD
     WHERE CREDIT_SUBGRADE = input_subgrade
$$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.UDF_GET_PD(VARCHAR(2))
     IS 'Probability of Default (PD): loan default probability based on customers credit score at origination.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT UDF_GET_PD('A1');
-- Expected: 0.00020000
-- Returned: 0.00020000

SELECT UDF_GET_PD('G5');
-- Expected: 0.30000000
-- Returned: 0.30000000

SELECT UDF_GET_PD('Z1');
-- Expected: NULL
-- Returned: NULL
