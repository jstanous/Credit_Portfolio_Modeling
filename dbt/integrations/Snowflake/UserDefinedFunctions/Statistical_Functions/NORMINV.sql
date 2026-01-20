/*------------------------------------------------------------------------------
Function: NORMINV
Location: UTIL_DB.PUBLIC
Purpose:
  Inverse Normal Probability Function replicating Excel's NORM.S.INV().
  Returns the z-score corresponding to a given probability p (0 < p < 1).
Notes:
  - Uses scipy.stats.norm.ppf under the hood.
  - Returns FLOAT (double precision).
  - For p <= 0 or p >= 1, returns NULL.
------------------------------------------------------------------------------*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE UTIL_DB;
USE SCHEMA PUBLIC;

CREATE OR REPLACE FUNCTION NORMINV
      (p FLOAT
      )
    RETURNS FLOAT
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.10'
    PACKAGES = ('scipy')
    HANDLER = 'run'
    AS
$$
from scipy.stats import norm

def run(p):
    if p is None or p <= 0 or p >= 1:
        return None

    return float(norm.ppf(float(p)))
$$;

COMMENT ON FUNCTION UTIL_DB.PUBLIC.NORMINV(FLOAT)
     IS 'Inverse Normal Probability Function replicating Excel NORM.S.INV()';
/*-----------------------------------
Unit Tests
-----------------------------------*/
SELECT UTIL_DB.PUBLIC.NORMINV(0.001);
-- Expected: -3.090232306 
-- Returned: -3.090232306

SELECT UTIL_DB.PUBLIC.NORMINV(0.01);
-- Expected: -2.326347874
-- Returned: -2.326347874

SELECT UTIL_DB.PUBLIC.NORMINV(0.05);
-- Expected: -1.644853627
-- Returned: -1.644853627

SELECT UTIL_DB.PUBLIC.NORMINV(0.500);
-- Expected: 0 
-- Returned: 0

SELECT UTIL_DB.PUBLIC.NORMINV(0.95);
-- Expected: 1.644853627
-- Returned: 1.644853627

SELECT UTIL_DB.PUBLIC.NORMINV(0.99);
-- Expected: 2.326347874
-- Returned: 2.326347874

SELECT UTIL_DB.PUBLIC.NORMINV(0.999);
-- Expected: 3.090232306 
-- Returned: 3.090232306
