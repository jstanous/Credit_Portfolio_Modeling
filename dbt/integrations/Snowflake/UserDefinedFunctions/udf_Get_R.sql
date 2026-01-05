/*------------------------------------------------------------------------------
Function: UDF_GET_R
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Calculates the Basel III IRB Asset Correlation (R) factor used in capital
  requirement formulas.
Notes:
  - Asset correlation reflects the relationship between borrower default risk
    and systemic economic conditions, and varies by exposure type.
  - Fixed values are pulled from CREDIT_PORTFOLIO.REF.R.
  - For Retail SME exposures (small/medium business loans), R is calculated
    using the Basel III IRB correlation formula.
  - Returns NUMBER(10,8).
  - Provides a sentinel fallback (0.99999999) if exposure type is not found.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION udf_Get_R
      (input_exposure_type VARCHAR(25)
      ,input_pd NUMBER(10,8)
      )
RETURNS NUMBER(10,8)
LANGUAGE SQL
AS
$$
COALESCE(
         (SELECT CASE input_exposure_type
                      WHEN 'Retail SME'
                           THEN CAST(
                                     (0.12 * ((1 - EXP(-50 * input_pd)) / (1 - EXP(-50)))
                                     +0.24 * (1 - ((1 - EXP(-50 * input_pd)) / (1 - EXP(-50))))
                                     )
                                     AS NUMBER(10,8))
                      ELSE R
                  END
            FROM CREDIT_PORTFOLIO.REF.R
           WHERE EXPOSURE_TYPE = input_exposure_type
         )
        ,0.99999999
        )
$$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.udf_Get_R(VARCHAR(25), NUMBER(10,8))
    IS 'Calculates the Basel III IRB Asset Correlation (R) factor used in capital requirement formulas.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT udf_Get_R('Retail SME', 0.025);
-- Expected: 0.15438058
-- Returned: 0.15438058

SELECT udf_Get_R('Credit Card', 0.025);
-- Expected: 0.04000000
-- Returned: 0.04000000

SELECT udf_Get_R('Mortgage', 0.025);
-- Expected: 0.15000000
-- Returned: 0.15000000

SELECT udf_Get_R('HELOC', 0.025);
-- Expected: 0.99999999
-- Returned: 0.99999999
