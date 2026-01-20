/*------------------------------------------------------------------------------
Function: UDF_GET_COF_RATE
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Determines the Cost of Funds rate used for market-based funding cost allocations.
Notes:
  - Returns NUMBER(10,8).
  - Matches term-length and pricing date to determine funding rate.
  - If term not recognized, returns 0.99999999.
  - If no matching date found, returns 0.88888888.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION UDF_GET_COF_RATE
      (input_pricing_date DATE
      ,input_pricing_term INTEGER
      )
    RETURNS NUMBER(10,8)
    LANGUAGE SQL
    AS
    $$
    COALESCE(
             (SELECT MIN(
                         CASE input_pricing_term
                              WHEN 36 THEN USD_COF_3Y
                              WHEN 60 THEN USD_COF_5Y
                              ELSE 0.99999999
                          END
                        )
                FROM CREDIT_PORTFOLIO.REF.COF_RATES
               WHERE AS_OF_DATE = input_pricing_date
             )
            ,0.88888888
            )
    $$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.udf_Get_CofRate(DATE, INTEGER)
     IS 'Determines the Cost of Funds rate used for market-based funding cost allocations.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT udf_Get_CofRate('2021-06-01', 36);
--Expected: 0.00422500
--Returned: 0.00422500

SELECT udf_Get_CofRate('2021-06-01', 60);
--Expected: 0.00924000
--Returned: 0.00924000

SELECT udf_Get_CofRate('2021-06-01', 120);
--Expected: 0.99999999
--Returned: 0.99999999

SELECT udf_Get_CofRate('2022-06-01', 36);
--Expected: 0.88888888
--Returned: 0.88888888
