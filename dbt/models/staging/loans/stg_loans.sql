-- stg_loans.sql
-- Purpose: Standardize column names from RAW.loans for clarity and consistency.
-- Loan attributes prefixed with loan_.
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
     , member_id                AS customer_id
  FROM {{source('credit_portfolio', 'loans') }}
