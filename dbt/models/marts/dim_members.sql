SELECT member_id
     , member_type
     , member_state
     , member_credit_grade              AS credit_grade
     , member_credit_subgrade           AS credit_subgrade
     , member_last_credit_report_date   AS last_credit_report_date
     , member_annual_income             AS annual_income
     , member_debt_to_income            AS debt_to_income
     , member_total_accounts            AS total_accounts
     , member_employment_tenure         AS employment_tenure
     , member_employment_title          AS employment_title
     , member_residence_status          AS residence_status
     , member_verification_status       AS verification_status
  FROM {{ ref('int_members') }}

/*
### Fields to include directly
- **member tenure** → earliest `issue_date` per member.
- **Employment tenure bucket** → derived from `emp_length`.
- **Income band** → e.g., `<25k`, `25–50k`, `50–100k`, `100k+`.
- **Credit utilization proxy** → ratio of `loan_amount` to `annual_income`.
- **Portfolio flags** → e.g., “ever charged off” (from `loan_status`), “ever fully paid.”
*/