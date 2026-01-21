/*------------------------------------------------------------------------------
Script: Snowflake_CreditPortfolio_Setup.sql
Purpose:
  Provision a modular Snowflake environment for the Credit Portfolio Modeling project.
  This script creates the CREDIT_PORTFOLIO database, dbt-specific schemas,
  and source and reference data tables to support credit modeling.

Steps:
  1. Database & Schema Setup
     - Uses SYSADMIN role and DBT_WH warehouse for object creation.
     - Creates DBT_DB.CREDIT_PORTFOLIO schema for dbt created internal deployment artifacts.
     - Creates CREDIT_PORTFOLIO database for production exemplars.
     - Drops CREDIT_PORTFOLIO.PUBLIC schema to enforce explicit schema usage.
     - Creates UTIL_DB database for reusable functions, file formats, and other tools.  

  2. Role & Privilege Grants
     - Uses SECURITYADMIN role for controlled privilege assignment.
     - Grants usage on CREDIT_PORTFOLIO database to DBT_ROLE.
     - Grants usage and object creation rights on all future schemas in CREDIT_PORTFOLIO.
     - Ensures dbt can create tables, views, stages, and file formats
       without manual re-granting.

  3. Production Schema Setup
     - Creates dbt-specific schemas in CREDIT_PORTFOLIO:
       RAW (raw data loads),
       REF (reference data),
       STAGING (staging models),
       INTERMEDIATES (intermediate models),
       MARTS (mart models).
       UDF (user defined functions).
     - Each schema includes comments clarifying its purpose.

  4. Data Tables
     - Raw Data Tables
       - LOANS: loan portfolio.
     - Reference Data Tables
       - COF_RATES: cost of funds rates.
       - PD: probability of default lookups for credit grades.
       - LOAN_PURPOSE: collateral and exposure type lookups for loan purposes.
       - LGD: loss given default lookups for collateral types.
       - R: asset correlation factor lookups for exposure type.
       - ASSERTIONS: asserted fixed rates used through credit modeling.
       - All tables include comments to clarify purpose and support lineage tracking.

  5. Data Stage
     - Creates internal stage for loading data into CREDIT_PORTFOLIO.
     - Stage created in CREDIT_PORTFOLIO.RAW schema.
     - Stage create with Directory Table enabled.
     - Stage setup with CSV file format where fields may be enclosed in quotes.

  6. Create File Format in UTIL_DB
     - This script provisions a system-wide file format for use across Snowflake ingestion routines.
     - It includes:
     - Uses dedicated UTIL_DB database for reusable tools and formats
     - A public file format named ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED
     - Configuration for CSV files with:
       - One header rows
       - Comma (,) delimiter
       - Optional quote enclosure
       - Space trimming
     - Governance Notes:
       - File format is stored in PUBLIC schema for cross-schema accessibility
       - Naming convention reflects structure and delimiter for clarity
       - This format supports ingestion of workshop files with legacy formatting
       -  This script is designed for public exemplars and can be reused across Snowflake workshops and dbt pipelines.

  7. Create Addional Reference Tables
     - Reference Data Tables
       - RISK_SEGMENT: Standard Risk Segment data.
       - REGION: BEA and Federal Reserve regionalization data.

Governance Notes:
  - Role usage alternates between SYSADMIN (object creation) and SECURITYADMIN (grants),
    demonstrating least-privilege principles.
  - PUBLIC schemas are dropped to avoid uncontrolled access.

Usage:
  Designed for public exemplars and reusable in Snowflake to support dbt modeling integration.
------------------------------------------------------------------------------*/
-- 1. Database & Schema Setup
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;

CREATE SCHEMA IF NOT EXISTS DBT_DB.CREDIT_PORTFOLIO
       COMMENT = 'Dedicated schema for dbt internal artifacts for credit portfolio project';

CREATE DATABASE IF NOT EXISTS CREDIT_PORTFOLIO
       COMMENT = 'Dedicated database for production artifacts credit portfolio project';
DROP SCHEMA IF EXISTS CREDIT_PORTFOLIO.PUBLIC;

CREATE DATABASE IF NOT EXISTS UTIL_DB
   COMMENT = 'Database to store system-wide available tools';

--2. Role & Privilege Grants
USE ROLE SECURITYADMIN;
GRANT USAGE ON DATABASE CREDIT_PORTFOLIO TO ROLE DBT_ROLE;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE CREDIT_PORTFOLIO TO ROLE DBT_ROLE;
GRANT USAGE ON FUTURE STAGES IN DATABASE CREDIT_PORTFOLIO TO ROLE DBT_ROLE;
GRANT CREATE TABLE
     ,CREATE VIEW
     ,CREATE STAGE
     ,CREATE FILE FORMAT
   ON FUTURE SCHEMAS IN DATABASE CREDIT_PORTFOLIO
   TO DBT_ROLE;


-- 3. Production Schema Setup
USE ROLE SYSADMIN;
USE DATABASE CREDIT_PORTFOLIO;
CREATE SCHEMA IF NOT EXISTS RAW
       COMMENT = 'Schema for credit portfolio raw loan data loads';

CREATE SCHEMA IF NOT EXISTS REF
       COMMENT = 'Schema for credit portfolio reference data loads';

CREATE SCHEMA IF NOT EXISTS STAGING
       COMMENT = 'Schema for credit portfolio staging models';

CREATE SCHEMA IF NOT EXISTS INTERMEDIATES
       COMMENT = 'Schema for credit portfolio intermediate models';

CREATE SCHEMA IF NOT EXISTS MARTS
       COMMENT = 'Schema for credit portfolio marts models';

CREATE SCHEMA IF NOT EXISTS UDF
       COMMENT = 'Schema for credit portfolio user defined functions';

-- 4. Data Tables
-- Raw Data Table
CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.RAW.LOANS
      (ID NUMBER(38,0)
      ,ADDRESS_STATE VARCHAR(2)
      ,APPLICATION_TYPE VARCHAR(25)
      ,EMP_LENGTH VARCHAR(25)
      ,EMP_TITLE VARCHAR(100)
      ,GRADE VARCHAR(1)
      ,HOME_OWNERSHIP VARCHAR(25)
      ,ISSUE_DATE DATE
      ,LAST_CREDIT_PULL_DATE DATE
      ,LAST_PAYMENT_DATE DATE
      ,LOAN_STATUS VARCHAR(25)
      ,NEXT_PAYMENT_DATE DATE
      ,MEMBER_ID NUMBER(38,0)
      ,PURPOSE VARCHAR(25)
      ,SUB_GRADE VARCHAR(2)
      ,TERM_LENGTH NUMBER(38,0)
      ,LENGTH_TYPE VARCHAR(10)
      ,VERIFICATION_STATUS VARCHAR(25)
      ,ANNUAL_INCOME NUMBER(38,2)
      ,DTI NUMBER(10,8)
      ,INSTALLMENT NUMBER(38,2)
      ,INT_RATE NUMBER(10,8)
      ,LOAN_AMOUNT NUMBER(38,2)
      ,TOTAL_ACC NUMBER(38,0)
      ,TOTAL_PAYMENT NUMBER(38,2))
      COMMENT = 'Table for Credit Portfolio Loan data';

-- Reference Data Tables
CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.COF_RATES
      (AS_OF_DATE DATE
      ,USD_COF_3Y NUMBER(10,8)
      ,USD_COF_5Y NUMBER(10,8))
      COMMENT = 'Reference Table for Cost of Funds Rates data';

CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.PD
      (CREDIT_GRADE VARCHAR(1)
      ,CREDIT_SUBGRADE VARCHAR(2)
      ,PD NUMBER(10,8))
      COMMENT = 'Reference Table for Probability of Default (PD) data';

CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.LOAN_PURPOSE
      (LOAN_PURPOSE VARCHAR(25)
      ,COLLATERAL_TYPE VARCHAR(25)
      ,EXPOSURE_TYPE VARCHAR(25))
      COMMENT = 'Reference Table for Loan Purpose driven lookup data';

CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.LGD
      (COLLATERAL_TYPE VARCHAR(25)
      ,LGD NUMBER(10,8))
      COMMENT = 'Reference Table for Loss Given Default (LGD) data';

CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.R
      (EXPOSURE_TYPE VARCHAR(25)
      ,R NUMBER(10,8))
      COMMENT = 'Reference Table for asset correlation (R)';

CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.ASSERTIONS
      (RATE_NAME VARCHAR(50)
      ,RATE_VALUE NUMBER(10,8))
      COMMENT = 'Reference Table for model-wide Asserted Rates data';

-- 5. Create Stage in Raw Schema
CREATE STAGE IF NOT EXISTS CREDIT_PORTFOLIO.RAW.CREDIT_PORTFOLIO_STAGE
       DIRECTORY = (ENABLE = TRUE)
       COMMENT = 'Stage for credit portfolio data loads';

-- 6. Create File Format in UTLI_DB
CREATE OR REPLACE FILE FORMAT UTIL_DB.PUBLIC.ONE_HEADERROW_COMMA_DELIM_DBLQUOTE_ENCLOSED
   TYPE = CSV,
   SKIP_HEADER = 1,
   FIELD_DELIMITER = ',',
   FIELD_OPTIONALLY_ENCLOSED_BY = '"',
   TRIM_SPACE = TRUE
   COMMENT = 'File Format: 1 Header Row, Comma delimited, DoubleQuote Enclosed';


-- 6. Create File Format in UTLI_DB
CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.RISK_SEGMENTS
      (
       CREDIT_GRADE CHAR(1),
       RISK_SEGMENT VARCHAR(25)
      )
      COMMENT = 'Reference Table for Risk Segments data';

INSERT INTO CREDIT_PORTFOLIO.REF.RISK_SEGMENTS
   VALUES
      ('A','Super-Prime'),
      ('B','Prime'),
      ('C','Near-Prime'),
      ('D','Sub-Prime'),
      ('E','Sub-Prime'),
      ('F','Deep Sub-Prime'),
      ('G','Deep Sub-Prime');


CREATE TABLE IF NOT EXISTS CREDIT_PORTFOLIO.REF.REGIONS
      (
       STATE_CD CHAR(2),
       DIVISION VARCHAR(50),
       REGION VARCHAR(50),
       FED_DISTRICT NUMBER(2,0),
       FED_DISTRICT_NAME VARCHAR(50)
      )
      COMMENT = 'Reference Table for regionalization data';

INSERT INTO CREDIT_PORTFOLIO.REF.REGIONS
   VALUES
      ('ME','New England','Northeast',1,'Boston'),
      ('NH','New England','Northeast',1,'Boston'),
      ('VT','New England','Northeast',1,'Boston'),
      ('MA','New England','Northeast',1,'Boston'),
      ('RI','New England','Northeast',1,'Boston'),
      ('CT','New England','Northeast',1,'Boston'),
      ('NY','Mideast','Northeast',2,'New York'),
      ('NJ','Mideast','Northeast',2,'New York'),
      ('PA','Mideast','Northeast',3,'Philadelphia'),
      ('DE','Mideast','Northeast',3,'Philadelphia'),
      ('MD','Mideast','Northeast',5,'Richmond'),
      ('DC','Mideast','Northeast',5,'Richmond'),
      ('OH','Great Lakes','Midwest',4,'Cleveland'),
      ('IN','Great Lakes','Midwest',7,'Chicago'),
      ('IL','Great Lakes','Midwest',7,'Chicago'),
      ('MI','Great Lakes','Midwest',7,'Chicago'),
      ('WI','Great Lakes','Midwest',7,'Chicago'),
      ('MN','Plains','Midwest',9,'Minneapolis'),
      ('IA','Plains','Midwest',7,'Chicago'),
      ('MO','Plains','Midwest',8,'St. Louis'),
      ('ND','Plains','Midwest',9,'Minneapolis'),
      ('SD','Plains','Midwest',9,'Minneapolis'),
      ('NE','Plains','Midwest',10,'Kansas City'),
      ('KS','Plains','Midwest',10,'Kansas City'),
      ('VA','Southeast','South',5,'Richmond'),
      ('WV','Southeast','South',5,'Richmond'),
      ('NC','Southeast','South',5,'Richmond'),
      ('SC','Southeast','South',5,'Richmond'),
      ('GA','Southeast','South',6,'Atlanta'),
      ('FL','Southeast','South',6,'Atlanta'),
      ('TN','Southeast','South',6,'Atlanta'),
      ('AL','Southeast','South',6,'Atlanta'),
      ('MS','Southeast','South',6,'Atlanta'),
      ('AR','Southeast','South',8,'St. Louis'),
      ('KY','Southeast','South',8,'St. Louis'),
      ('LA','Southeast','South',11,'Dallas'),
      ('OK','Southwest','South',10,'Kansas City'),
      ('TX','Southwest','South',11,'Dallas'),
      ('MT','Rocky Mountain','West',9,'Minneapolis'),
      ('ID','Rocky Mountain','West',12,'San Francisco'),
      ('WY','Rocky Mountain','West',10,'Kansas City'),
      ('CO','Rocky Mountain','West',10,'Kansas City'),
      ('NM','Rocky Mountain','West',11,'Dallas'),
      ('AZ','Rocky Mountain','West',12,'San Francisco'),
      ('UT','Rocky Mountain','West',12,'San Francisco'),
      ('NV','Far West','West',12,'San Francisco'),
      ('WA','Far West','West',12,'San Francisco'),
      ('OR','Far West','West',12,'San Francisco'),
      ('CA','Far West','West',12,'San Francisco'),
      ('AK','Far West','West',12,'San Francisco'),
      ('HI','Far West','West',12,'San Francisco');
