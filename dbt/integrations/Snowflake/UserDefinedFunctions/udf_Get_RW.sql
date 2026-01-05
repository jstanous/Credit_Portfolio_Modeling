/*------------------------------------------------------------------------------
Function: UDF_GET_RW
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Calculates the Basel III IRB Risk Weight (RW) component of the capital
  requirement formula.
Notes:
  - Returns NUMBER(10,8).
  - Risk Weight represents the sensitivity of capital requirements to borrower
    default probability and asset correlation, and is derived from the Vasicek
    single-factor model:
    RW = ((1 - R) / (1 - R * b)) *
         [ Φ⁻¹(PD) * √R + Φ⁻¹(0.999) * √(1 - R) ]²
    where:
      - PD = Probability of Default
      - R  = Asset Correlation
      - b  = Maturity Adjustment Factor
      - Φ⁻¹ = Inverse Normal Probability Function (NORMINV)
  - RW is a core input to the capital factor K = LGD × RW.
  - Uses UTIL_DB.PUBLIC.NORMINV for inverse normal calculations.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION CREDIT_PORTFOLIO.UDF.udf_Get_RW(pd FLOAT, r FLOAT, b FLOAT)
RETURNS FLOAT
LANGUAGE SQL
AS
$$
 ((1 - r) / (1 - r * b)) * POWER(
            UTIL_DB.PUBLIC.NORMINV(pd) * SQRT(r) +
            UTIL_DB.PUBLIC.NORMINV(0.999) * SQRT(1 - r)
         , 2)

$$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.udf_Get_RW(FLOAT, FLOAT, FLOAT)
    IS 'Calculates the Basel III IRB Risk Weight (RW) portion of the capital factor used in capital requirement formulas.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT CREDIT_PORTFOLIO.UDF.udf_Get_RW(0.001, 0.24, 1.0);
-- Expected: Small RW value (~0.038)

SELECT udf_Get_RW(0.025, 0.15, 1.0);
-- Expected: Mid-range RW value (~0.154)

SELECT udf_Get_RW(0.20, 0.12, 1.0);
-- Expected: Larger RW value (~0.240)

SELECT NORMAL_INV(.5);