/*------------------------------------------------------------------------------
Function: UDF_GET_LGD
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Loss Given Default (LGD): loss rate at loan default based on assets used to secure loan.
Notes:
  - Returns NUMBER(10,8).
  - Pulls LGD values from CREDIT_PORTFOLIO.REF.LGD based on collateral type.
  - If collateral type not found, returns 0.99999999 as a sentinel/fallback.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION udf_Get_LGD
      (input_collateral_type VARCHAR(25)
      )
    RETURNS NUMBER(10,8)
    LANGUAGE SQL
    AS
    $$
    COALESCE(
             (SELECT MIN(LGD)
                FROM CREDIT_PORTFOLIO.REF.LGD
               WHERE COLLATERAL_TYPE = input_collateral_type
             )
            ,0.99999999
            )
    $$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.udf_Get_LGD(VARCHAR(25))
     IS 'Gets the Loss Given Default (LGD): loss rate at loan default based on assets used to secure loan.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT udf_Get_LGD('Property (Lien)');
-- Expected: 0.35000000
-- Returned: 0.35000000

SELECT udf_Get_LGD('Unsecured');
-- Expected: 0.75000000
-- Returned: 0.75000000

SELECT udf_Get_LGD('Baseball Cards');
-- Expected: 0.99999999
-- Returned: 0.99999999
