-- stg_members.sql
-- Purpose: Standardize column names from RAW.loans for clarity and consistency.
-- member attributes prefixed with member_.
SELECT member_id                AS member_id
     , application_type         AS member_type
     , address_state            AS member_state
     , grade                    AS member_credit_grade
     , sub_grade                AS member_credit_subgrade
     , last_credit_pull_date    AS member_last_credit_report_date
     , annual_income            AS member_annual_income
     , dti                      AS member_debt_to_income
     , total_acc                AS member_total_accounts
     , emp_length               AS member_employment_tenure
     , emp_title                AS member_employment_title
     , home_ownership           AS member_residence_status
     , verification_status      AS member_verification_status
FROM {{source('credit_portfolio', 'loans') }}
