/*===========================================================================================
  Artifact:     NORMINV Benchmark Execution Script
  Purpose:      Populate PYFUNC, SQLFUNC, and SQLUPD columns across all benchmark tables
                using three execution models:
                  (1) Python UDF
                  (2) SQL UDF
                  (3) SQL Lookup Table

  Notes:
    • Each UPDATE is executed independently to capture timing in Snowflake query history.
    • Lookup table resolution uses a deterministic join on P = SEED_P.
===========================================================================================*/

USE ROLE SYSADMIN;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

-- ============================================================
-- 1 ROW
-- ============================================================
UPDATE BENCH_NORMINV_1
   SET PYFUNC = UTIL_DB.PUBLIC.NORMINV(SEED_P);

UPDATE BENCH_NORMINV_1
   SET SQLFUNC = CREDIT_PORTFOLIO.UDF.UDF_GET_NORMINV(SEED_P);

UPDATE BENCH_NORMINV_1
   SET SQLUPD = NORMINV
  FROM CREDIT_PORTFOLIO.REF.NORMINV
 WHERE P = SEED_P;

-- ============================================================
-- 100 ROWS
-- ============================================================
UPDATE BENCH_NORMINV_100
   SET PYFUNC = UTIL_DB.PUBLIC.NORMINV(SEED_P);

UPDATE BENCH_NORMINV_100
   SET SQLFUNC = CREDIT_PORTFOLIO.UDF.UDF_GET_NORMINV(SEED_P);

UPDATE BENCH_NORMINV_100
   SET SQLUPD = NORMINV
  FROM CREDIT_PORTFOLIO.REF.NORMINV
 WHERE P = SEED_P;

-- ============================================================
-- 10,000 ROWS
-- ============================================================
UPDATE BENCH_NORMINV_10K
   SET PYFUNC = UTIL_DB.PUBLIC.NORMINV(SEED_P);

UPDATE BENCH_NORMINV_10K
   SET SQLFUNC = CREDIT_PORTFOLIO.UDF.UDF_GET_NORMINV(SEED_P);

UPDATE BENCH_NORMINV_10K
   SET SQLUPD = NORMINV
  FROM CREDIT_PORTFOLIO.REF.NORMINV
 WHERE P = SEED_P;

-- ============================================================
-- 1,000,000 ROWS
-- ============================================================
UPDATE BENCH_NORMINV_1M
   SET PYFUNC = UTIL_DB.PUBLIC.NORMINV(SEED_P);

UPDATE BENCH_NORMINV_1M
   SET SQLFUNC = CREDIT_PORTFOLIO.UDF.UDF_GET_NORMINV(SEED_P);

UPDATE BENCH_NORMINV_1M
   SET SQLUPD = NORMINV
  FROM CREDIT_PORTFOLIO.REF.NORMINV
 WHERE P = SEED_P;

-- ============================================================
-- 100,000,000 ROWS
-- ============================================================
UPDATE BENCH_NORMINV_100M
   SET PYFUNC = UTIL_DB.PUBLIC.NORMINV(SEED_P);

UPDATE BENCH_NORMINV_100M
   SET SQLFUNC = CREDIT_PORTFOLIO.UDF.UDF_GET_NORMINV(SEED_P);

UPDATE BENCH_NORMINV_100M
   SET SQLUPD = NORMINV
  FROM CREDIT_PORTFOLIO.REF.NORMINV
 WHERE P = SEED_P;
