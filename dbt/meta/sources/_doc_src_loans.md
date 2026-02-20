{% docs source__credit_portfolio %}  
Copy of the 2021 Credit Portfolio data.  
{% enddocs %}  

{% docs table__loans %}  
Loan Summary records for the 2021 Credit Portfolio.  

** Source: ** credit_portfolio.raw.loans  
** Grain: ** One record per loan.  
{% enddocs %}  

<!-- Loan Attributes -->
{% docs column__loan_id %}  
Unique identifier for the loan record.  
  
** Business Name: ** Loan Id  
** Source: ** credit_portfolio.raw.loans.id  
** Role: ** Primary Key  
  
** Use case: ** Identify unique loans.  
{% enddocs %}  

{% docs column__loan_origination_date %}  
Date of origination for the loan record.  

** Business Name: ** Origination Date  
** Source: ** credit_portfolio.raw.loans.issue_date  

** Use case: ** Identify the date the loans started.  
{% enddocs %}  

{% docs column__loan_amount %}  
Original funded amount of the loan record.  

** Business Name: ** Loan Amount  
** Source: ** credit_portfolio.raw.loans.loan_amount  

** Use case: ** Identify the initial amount of the loan.  
{% enddocs %}  

{% docs column__loan_term %}  
The length of the loan in units designated by Term Type.  

** Business Name: ** Loan Term  
** Source: ** credit_portfolio.raw.loans.term_length  

** Use case: ** Identify the initial length of the loan.  
{% enddocs %}  

{% docs column__loan_term_type %}  
The unit for the loan term.  

** Business Name: ** Loan Term Type  
** Source: ** credit_portfolio.raw.loans.length_type  

** Use case: ** Identify the unit of length of the loan term.  

** Values: **  
 - months  
{% enddocs %}  

{% docs column__loan_interest_rate %}  
The annual interest rate applied to the loan balance.  

** Business Name: ** Interest Rate  
** Source: ** credit_portfolio.raw.loans.int_rate  

** Use case: ** Identify the annual interest rate for the loans.  
{% enddocs %}  

{% docs column__loan_payment_amount %}  
The monthly payment amount of the loan.  

** Business Name: ** Payment Amount  
** Source: ** credit_portfolio.raw.loans.installment  

** Use case: ** Identify the monthly payment amounts for the loans.  
{% enddocs %}  

{% docs column__loan_last_payment_date %}  
The date of the last monthly payment for the loan.  

** Business Name: ** Last Payment Date  
** Source: ** credit_portfolio.raw.loans.last_payment_date  

** Use case: ** Identify the date of the last payment made for the loans.  
{% enddocs %}  

{% docs column__loan_next_payment_date %}  
The date the next monthly payment is due for the loan.  

** Business Name: ** Next Payment Date  
** Source: ** credit_portfolio.raw.loans.next_payment_date  

** Use case: ** Identify the date the next payment is due for the loans.  
{% enddocs %}  

{% docs column__loan_total_payment_amount %}  
The total amount of loan payments.  

** Business Name: ** Total Payment Amount  
** Source: ** credit_portfolio.raw.loans.total_payment  

** Use case: ** Identify the total payment amount for the loans.  
{% enddocs %}  

{% docs column__loan_status %}  
The status of the loans.  

** Business Name: ** Loan Status  
** Source: ** credit_portfolio.raw.loans.loan_status  

** Use case: ** Identify the status of the loan.  

** Values: **  
 - Charged Off — Delinquent loan written off
 - Fully Paid — Loan fully repaid
 - Current — Loan is current
{% enddocs %}  

{% docs column__loan_purpose %}  
The indicated use for loans.  

** Business Name: ** Loan Purpose  
** Source: ** credit_portfolio.raw.loans.purpose  
** Role: ** Foreign Key to ref.loan_purpose.loan_purpose.  

** Use case: ** Identify the purpose of the loan.  
{% enddocs %}  

<!-- Member Attributes -->
{% docs column__member_id %}  
Unique identifier for the member.  
  
** Business Name: ** Member Id  
** Source: ** credit_portfolio.raw.loans.member_id  
** Role: ** Primary Key for member records  
  
** Use case: ** Identify unique members.  
{% enddocs %}  

{% docs column__member_type %}  
The type of the members.  
  
** Business Name: ** Member Type  
** Source: ** credit_portfolio.raw.loans.application_type  
  
** Use case: ** Identify the type of member.  

** Values: **  
 - INDIVIDUAL — The member is an individual person.
{% enddocs %}  

{% docs column__member_state %}  
The state of residence for the members.  
  
** Business Name: ** Member State  
** Source: ** credit_portfolio.raw.loans.address_state  
  
** Use case: ** Identify the state of residence for the member.  

** Values: **  
 - Must be a valid 2 character state code
{% enddocs %}  

{% docs column__member_credit_grade %}  
The credit grade for the members.  
  
** Business Name: ** Credit Grade  
** Source: ** credit_portfolio.raw.loans.grade  
  
** Use case: ** Identify the credit grade for the member.  

** Values: **  
 - A — Exceptional
 - B — Very Good
 - C — Good
 - D — Fair
 - E — Poor
 - F — Very Poor
 - G — High Risk
{% enddocs %}  

{% docs column__member_credit_subgrade %}  
The credit subgrade of the members.

** Business Name: ** Credit Subgrade  
** Source: ** credit_portfolio.raw.loans.subgrade  
  
** Use case: ** Identify the credit subgrade for the member.  

** Values: **  
 - Numeric tiers (1-5) within each credit grade.
{% enddocs %}  

{% docs column__member_last_credit_report_date %}  
The date of the last credit report pull for the members.

** Business Name: ** Last Credit Report Date  
** Source: ** credit_portfolio.raw.loans.last_credit_pull_date  
  
** Use case: ** Identify the date of the last credit report pull for the member.  
{% enddocs %}  

{% docs column__member_annual_income %}  
The annual income for the members.

** Business Name: ** Annual Income  
** Source: ** credit_portfolio.raw.loans.annual_income  
  
** Use case: ** Identify the date of the last credit report pull for the member.  
{% enddocs %}  

{% docs column__member_debt_to_income %}  
The debt-to-income ratio for the members.

** Business Name: ** Debt-to-Income  
** Source: ** credit_portfolio.raw.loans.dti  
  
** Use case: ** Identify the ratio of debt to income for the member.  
{% enddocs %}  

{% docs column__member_total_accounts %}  
The total number of accounts for the members.

** Business Name: ** Total Accounts  
** Source: ** credit_portfolio.raw.loans.total_acc  
  
** Use case: ** Identify the total number of accounts for the member.  
{% enddocs %}  

{% docs column__member_employment_tenure %}  
The length of time of current employment for the members.

** Business Name: ** Employment Tenure  
** Source: ** credit_portfolio.raw.loans.emp_length  
  
** Use case: ** Identify the length of time of current employment for the member.  
{% enddocs %}  

{% docs column__member_employment_title %}  
The current employment title for the members.

** Business Name: ** Employment Title  
** Source: ** credit_portfolio.raw.loans.emp_title  
  
** Use case: ** Identify the employment title for the member.  
{% enddocs %}  

{% docs column__member_residence_status %}  
The situation of the residence for the members.

** Business Name: ** Residence Status  
** Source: ** credit_portfolio.raw.loans.home_ownership  
  
** Use case: ** Identify the residence situation for the member.  

** Values: **  
 - MORTGAGE — Pays a mortgage on current residence.  
 - NONE — Unknown residence situation.  
 - OTHER —  Other residence situation.
 - OWN — Owns current residence.
 - RENT — Rents current residence.
{% enddocs %}  

{% docs column__member_verification_status %}  
The status of verification of information for the members.

** Business Name: ** Verification Status  
** Source: ** credit_portfolio.raw.loans.verification_status  
  
** Use case: ** Identify the information verification status for the member.  
{% enddocs %}  
