/*------------------------------------------------------------------------------
Function: UDF_CALC_M_TWA
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Term Average-Weighted Remaining Maturity for the original loan term.
Notes:
  - Returns in YEARS as NUMBER(10,8).
  - Defaults: floor = 12 months, ceiling = 60 months.
  - Floor and ceiling are optional inputs; if omitted, defaults apply.
  - This is non-standard under Basel III IRB and should not be used for regulatory capital reporting.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION UDF_CALC_M_TWA
      (term_months NUMBER
      ,m_floor NUMBER DEFAULT 12
      ,m_ceiling NUMBER DEFAULT 60
      )
    RETURNS NUMBER(10,8)
    LANGUAGE SQL
    AS
    $$
    WITH cte_seg AS
        (SELECT LEAST(
                      GREATEST(
                               ROW_NUMBER() OVER (ORDER BY SEQ4())
                               ,m_floor
                              )
                      ,m_ceiling
                     )  AS seq
           FROM TABLE(GENERATOR(ROWCOUNT => term_months)) v
        )
    SELECT CAST(SUM(seq) / term_months / 12 AS NUMBER(10,8))
      FROM cte_seg
    $$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.UDF_CALC_M_TWA(NUMBER, NUMBER, NUMBER)
     IS 'Calculates the Term Average-Weighted Remaining Maturity for the original loan term.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT UDF_CALC_M_TWA(60);
-- Expected: 2.63333333
-- Returned: 2.63333333

SELECT UDF_CALC_M_TWA(60, 0);
-- Expected: 2.54166667
-- Returned: 2.54166667

SELECT UDF_CALC_M_TWA(36);
-- Expected: 1.69444442
-- Returned: 1.69444442

SELECT UDF_CALC_M_TWA(36,0);
-- Expected: 1.54166667
-- Returned: 1.54166667

SELECT UDF_CALC_M_TWA(12);
-- Expected: 1.00000000
-- Returned: 1.00000000
