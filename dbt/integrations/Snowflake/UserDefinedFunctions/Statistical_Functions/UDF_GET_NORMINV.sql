/*------------------------------------------------------------------------------
Function: UDF_GET_NORMINV
Location: CREDIT_PORTFOLIO.UDF
Purpose:
  Pulls precalculated NORMINV for p-stat input as scale 6.

Notes:
  - Returns FLOAT.
  - Pulls NORMINV values from CREDIT_PORTFOLIO.REF.NORMINV based on p-stat.
  - p-stat values are expected to be between 0 and 1.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE FUNCTION UDF_GET_NORMINV
      (p_stat NUMBER(8,6)
      )
RETURNS FLOAT
LANGUAGE SQL
AS
$$
SELECT MIN(NORMINV) 
  FROM CREDIT_PORTFOLIO.REF.NORMINV
 WHERE P = p_stat
$$;

COMMENT ON FUNCTION CREDIT_PORTFOLIO.UDF.udf_Get_NORMINV(NUMBER(8,6))
     IS 'Pulls precalculated NORMINV for p-stat input as scale 6.';

/*-----------------------------------
Unit Tests
-----------------------------------*/
