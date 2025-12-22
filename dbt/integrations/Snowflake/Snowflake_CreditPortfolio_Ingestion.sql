/*------------------------------------------------------------------------------
Script: Snowflake_CreditPortfolio_Ingestion.sql
Purpose:
  Load Credit Portfolio Modeling datasets from staged data to the RAW and REF schemas
  of the CREDIT_PORTFOLIO database. This script provisions baseline data for modeling
  credit portfolio data in dbt. Validates ingestion with simple SELECT queries.

Steps:
  1. Context Setup
     - Uses DBT_WH warehouse for execution.
     - Runs under DBT_ROLE to enforce least-privilege access.
     - Switches to CREDIT_PORTFOLIO database and RAW schema.

  2. Data Cleaning
     - Truncates tables in RAW and REF schemas to ensure clean loads

  3. Data Ingestion
     - All COPY INTO commands use CSV file format with header skip.

  4. Validation
     - Executes SELECT queries against RAW and REF data.
     - Confirms successful ingestion and allows quick inspection of loaded records.

Governance Notes:
  - Ingestion runs under DBT_ROLE, not SYSADMIN, to demonstrate controlled access.
  - Project csv files must be loaded into CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE prior to ingestion.
  - RAW and REF schema separation ensures lineage clarity between raw and ref loads,
    staging transformations, and downstream marts.

Usage:
  Designed for public exemplars and reusable in Snowflake to support dbt credit portfolio modeling.
------------------------------------------------------------------------------*/
-- 1. Context Setup
USE ROLE DBT_ROLE;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA RAW;

-- 2. Clear Tables
TRUNCATE TABLE CREDIT_PORTFOLIO.RAW.LOANS;
TRUNCATE TABLE CREDIT_PORTFOLIO.REF.COF_RATES;
TRUNCATE TABLE CREDIT_PORTFOLIO.REF.PD;
TRUNCATE TABLE CREDIT_PORTFOLIO.REF.LOAN_PURPOSE;
TRUNCATE TABLE CREDIT_PORTFOLIO.REF.LGD;
TRUNCATE TABLE CREDIT_PORTFOLIO.REF.R;
TRUNCATE TABLE CREDIT_PORTFOLIO.REF.ASSERTIONS;

-- 3. Data Ingestion
COPY INTO CREDIT_PORTFOLIO.RAW.LOANS
    (ID
    ,ADDRESS_STATE
    ,APPLICATION_TYPE
    ,EMP_LENGTH
    ,EMP_TITLE
    ,GRADE
    ,HOME_OWNERSHIP
    ,ISSUE_DATE
    ,LAST_CREDIT_PULL_DATE
    ,LAST_PAYMENT_DATE
    ,LOAN_STATUS
    ,NEXT_PAYMENT_DATE
    ,MEMBER_ID
    ,PURPOSE
    ,SUB_GRADE
    ,TERM_LENGTH
    ,LENGTH_TYPE
    ,VERIFICATION_STATUS
    ,ANNUAL_INCOME
    ,DTI
    ,INSTALLMENT
    ,INT_RATE
    ,LOAN_AMOUNT
    ,TOTAL_ACC
    ,TOTAL_PAYMENT)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/Financial_Loan.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;

COPY INTO CREDIT_PORTFOLIO.REF.COF_RATES
    (AS_OF_DATE
    ,USD_COF_3Y
    ,USD_COF_5Y)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/ref_CostOfFundsRates.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;
  
COPY INTO CREDIT_PORTFOLIO.REF.PD
    (CREDIT_GRADE
    ,CREDIT_SUBGRADE
    ,PD)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/ref_ProbabilityOfDefault.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;

COPY INTO CREDIT_PORTFOLIO.REF.LOAN_PURPOSE
    (LOAN_PURPOSE
    ,COLLATERAL_TYPE
    ,EXPOSURE_TYPE)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/ref_LoanPurpose.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;

COPY INTO CREDIT_PORTFOLIO.REF.LGD
    (COLLATERAL_TYPE
    ,LGD)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/ref_LossGivenDefault.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;

COPY INTO CREDIT_PORTFOLIO.REF.R
    (EXPOSURE_TYPE
    ,R)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/ref_AssetCorrelation.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;

COPY INTO CREDIT_PORTFOLIO.REF.ASSERTIONS
    (RATE_NAME
    ,RATE_VALUE)
FROM '@CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE/ref_AssertedRates.csv'
     FILE_FORMAT = UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED;

-- 4. Validation
SELECT * FROM CREDIT_PORTFOLIO.RAW.LOANS LIMIT 10;
SELECT * FROM CREDIT_PORTFOLIO.REF.COF_RATES LIMIT 10;
SELECT * FROM CREDIT_PORTFOLIO.REF.PD LIMIT 10;
SELECT * FROM CREDIT_PORTFOLIO.REF.LOAN_PURPOSE LIMIT 10;
SELECT * FROM CREDIT_PORTFOLIO.REF.LGD LIMIT 10;
SELECT * FROM CREDIT_PORTFOLIO.REF.R LIMIT 10;
SELECT * FROM CREDIT_PORTFOLIO.REF.ASSERTIONS LIMIT 10;
