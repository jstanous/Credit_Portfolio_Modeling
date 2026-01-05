/*===========================================================================================
  Artifact:     NORMINV Benchmark Seed Tables (Scale‑6)
  Context:      Basel IRB – Performance Benchmarking Framework
  Purpose:      Generate deterministic p-value seed tables of varying sizes to support
                performance testing across three execution models:
                (1) Python UDF, (2) SQL UDF, and (3) SQL Lookup Table.

  Overview:
    Each table is generated using a uniform seeding strategy:
        p = ROW_NUMBER() * 0.000001
    This produces a reproducible, evenly distributed PD domain at 6‑decimal precision.
    For rowcounts exceeding 999,999, PD values repeat cyclically, which is desirable for
    stress‑testing function execution and update behavior at scale.

  Scenarios:
    • 1 row
    • 100 rows
    • 10,000 rows
    • 1,000,000 rows
    • 100,000,000 rows

  Schema (consistent across all scenarios):
    SEED_P        NUMBER(10,6)   – Deterministic PD value
    PYFUNC        FLOAT          – Python UDF result (populated during benchmark)
    SQLFUNC       FLOAT          – SQL UDF result (populated during benchmark)
    SQLUPD        FLOAT          – Lookup-table result (populated during benchmark)

  Notes:
    • Tables are intentionally generated empty in PYFUNC/SQLFUNC/SQLUPD columns.
      Benchmark scripts will populate each column independently.
    • Using sequential PDs isolates function performance from data skew.
    • Repeated PDs at high rowcounts simulate realistic production workloads.

===========================================================================================*/
USE ROLE SYSADMIN;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

CREATE OR REPLACE TABLE BENCH_NORMINV_1 AS
SELECT 
      (ROW_NUMBER() OVER (ORDER BY SEQ4())) * 0.000001 AS SEED_P
    , NULL::FLOAT AS PYFUNC
    , NULL::FLOAT AS SQLFUNC
    , NULL::FLOAT AS SQLUPD
FROM TABLE(GENERATOR(ROWCOUNT => 1));

CREATE OR REPLACE TABLE BENCH_NORMINV_100 AS
SELECT 
      (ROW_NUMBER() OVER (ORDER BY SEQ4())) * 0.000001 AS SEED_P
    , NULL::FLOAT AS PYFUNC
    , NULL::FLOAT AS SQLFUNC
    , NULL::FLOAT AS SQLUPD
FROM TABLE(GENERATOR(ROWCOUNT => 100));

CREATE OR REPLACE TABLE BENCH_NORMINV_10K AS
SELECT 
      (ROW_NUMBER() OVER (ORDER BY SEQ4())) * 0.000001 AS SEED_P
    , NULL::FLOAT AS PYFUNC
    , NULL::FLOAT AS SQLFUNC
    , NULL::FLOAT AS SQLUPD
FROM TABLE(GENERATOR(ROWCOUNT => 10000));

CREATE OR REPLACE TABLE BENCH_NORMINV_1M AS
SELECT 
      (ROW_NUMBER() OVER (ORDER BY SEQ4())) * 0.000001 AS SEED_P
    , NULL::FLOAT AS PYFUNC
    , NULL::FLOAT AS SQLFUNC
    , NULL::FLOAT AS SQLUPD
FROM TABLE(GENERATOR(ROWCOUNT => 1000000));

UPDATE BENCH_NORMINV_1M
   SET SEED_P = .999999
 WHERE SEED_P = 1;

CREATE OR REPLACE TABLE BENCH_NORMINV_100M AS
SELECT 
      ROUND((ROW_NUMBER() OVER (ORDER BY SEQ4())) * 0.00000001, 6) AS SEED_P
    , NULL::FLOAT AS PYFUNC
    , NULL::FLOAT AS SQLFUNC
    , NULL::FLOAT AS SQLUPD
FROM TABLE(GENERATOR(ROWCOUNT => 100000000));

UPDATE BENCH_NORMINV_100M
   SET SEED_P = .000001
 WHERE SEED_P = 0;

UPDATE BENCH_NORMINV_100M
   SET SEED_P = .999999
 WHERE SEED_P = 1;
