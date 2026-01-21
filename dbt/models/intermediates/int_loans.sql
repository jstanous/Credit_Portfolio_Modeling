SELECT loans.loan_id
     , loans.member_id
     , loans.loan_origination_date
     , DATEADD(month, loans.loan_term, loans.loan_origination_date) as loan_maturity_date
     , loans.loan_amount
     , loans.loan_term
     , loans.loan_term_type
     , loans.loan_interest_rate
     , loans.loan_payment_amount
     , loans.loan_last_payment_date
     , loans.loan_next_payment_date
     , loans.loan_total_payment_amount
     , loans.loan_status
     , loans.loan_purpose
     , loan_purpose.collateral_type
     , loan_purpose.exposure_type
  FROM {{ ref('stg_loans') }}        as loans
  JOIN {{ ref('ref_loan_purpose') }} as loan_purpose
    ON loans.loan_purpose = loan_purpose.loan_purpose
