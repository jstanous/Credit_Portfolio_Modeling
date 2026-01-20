-- stg_customers.sql
-- Purpose: Standardize column names from RAW.loans for clarity and consistency.
-- customer attributes prefixed with customer_.
SELECT member_id                AS customer_id
     , application_type         AS customer_type
     , address_state            AS customer_state
     , grade                    AS customer_credit_grade
     , sub_grade                AS customer_credit_subgrade
     , last_credit_pull_date    AS customer_last_credit_report_date
     , annual_income            AS customer_annual_income
     , dti                      AS customer_debt_to_income
     , total_acc                AS customer_total_accounts
     , emp_length               AS customer_employment_tenure
     , emp_title                AS customer_employment_title
     , home_ownership           AS customer_residence_status
     , verification_status      AS customer_verification_status
FROM {{source('credit_portfolio', 'loans') }}
