-- stg_loans.sql
-- Purpose: Standardize column names from RAW.loans for clarity and consistency.
-- Loan attributes prefixed with loan_, borrower attributes prefixed with borrower_.
SELECT borrower_id
     , borrower_type
     , borrower_state
     , borrower_credit_grade
     , borrower_credit_subgrade
     , borrower_last_credit_report_date
     , borrower_annual_income
     , borrower_debt_to_income
     , borrower_total_accounts
     , borrower_employment_tenure
     , borrower_employment_title
     , borrower_residence_status
     , borrower_verification_status
  FROM {{ ref('stg_loans') }}
