SELECT member_id
     , member_type
     , member_state
     , member_credit_grade
     , member_credit_subgrade
     , member_last_credit_report_date
     , member_annual_income
     , member_debt_to_income
     , member_total_accounts
     , member_employment_tenure
     , member_employment_title
     , member_residence_status
     , member_verification_status
  FROM {{ ref('stg_members') }}

/*
### Fields to include directly
- **member tenure** → earliest `issue_date` per member.
- **Employment tenure bucket** → derived from `emp_length`.
- **Income band** → e.g., `<25k`, `25–50k`, `50–100k`, `100k+`.
- **Credit utilization proxy** → ratio of `loan_amount` to `annual_income`.
- **Portfolio flags** → e.g., “ever charged off” (from `loan_status`), “ever fully paid.”
*/