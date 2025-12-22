-- stg_loans.sql
-- Purpose: Standardize column names from RAW.loans for clarity and consistency.
-- Loan attributes prefixed with loan_, borrower attributes prefixed with borrower_.
SELECT id                       AS loan_id
     , issue_date               AS loan_origination_date
     , loan_amount              AS loan_amount
     , term_length              AS loan_term
     , length_type              AS loan_term_type
     , int_rate                 AS loan_interest_rate
     , installment              AS loan_payment_amount
     , last_payment_date        AS loan_last_payment_date
     , next_payment_date        AS loan_next_payment_date
     , total_payment            AS loan_total_payment_amount
     , loan_status              AS loan_status
     , purpose                  AS loan_purpose
     , member_id                AS borrower_id
     , application_type         AS borrower_type
     , address_state            AS borrower_state
     , grade                    AS borrower_credit_grade
     , sub_grade                AS borrower_credit_subgrade
     , last_credit_pull_date    AS borrower_last_credit_report_date
     , annual_income            AS borrower_annual_income
     , dti                      AS borrower_debt_to_income
     , total_acc                AS borrower_total_accounts
     , emp_length               AS borrower_employment_tenure
     , emp_title                AS borrower_employment_title
     , home_ownership           AS borrower_residence_status
     , verification_status      AS borrower_verification_status
  FROM {{source('credit_portfolio', 'loans') }}
