{% docs source__credit_portfolio %}  
Copy of the 2021 Credit Portfolio data.  
{% enddocs %}  

{% docs table__loans %}  
Loan Summary records for the 2021 Credit Portfolio.  

** Source: ** raw.loans  
** Grain: ** One record per loan.  
{% enddocs %}  

<!-- Loan Attributes -->
{% docs column__loan_id %}  
Unique identifier for the loan record.  
  
** Business Name: ** Loan Id  
** Source: ** loans.id  
** Role: ** Primary Key  
  
** Use case: ** Indentify unique loans.  
{% enddocs %}  

{% docs column__loan_origination_date %}  
Date of origination for the loan record.  

** Business Name: ** Origination Date  
** Source: ** loans.issue_date  

** Use case: ** Indentify the date the loans started.  
{% enddocs %}  

{% docs column__loan_amount %}  
Original funded amount of the loan record.  

** Business Name: ** Loan Amount  
** Source: ** loans.loan_amount  

** Use case: ** Indentify the initial amount of the loan.  
{% enddocs %}  

{% docs column__loan_term %}  
The length of the loan in units designated by Term Type.  

** Business Name: ** Loan Term  
** Source: ** loans.term_length  

** Use case: ** Indentify the initial length of the loan.  
{% enddocs %}  

{% docs column__loan_term_type %}  
The unit for the loan term.  

** Business Name: ** Loan Term Type  
** Source: ** loans.length_type  

** Use case: ** Indentify the unit of length of the loan term.  

** Values: **  
 - months  
{% enddocs %}  

{% docs column__loan_interest_rate %}  
The annual interest rate applied to the loan balance.  

** Business Name: ** Interest Rate  
** Source: ** loans.int_rate  

** Use case: ** Indentify the annual interest rate for the loans.  
{% enddocs %}  

{% docs column__loan_payment_amount %}  
The monthly payment amount of the loan.  

** Business Name: ** Payment Amount  
** Source: ** loans.installment  

** Use case: ** Indentify the monthly payment amounts for the loans.  
{% enddocs %}  

{% docs column__loan_last_payment_date %}  
The date of the last monthly payment for the loan.  

** Business Name: ** Last Payment Date  
** Source: ** loans.last_payment_date  

** Use case: ** Indentify the date of the last payment made for the loans.  
{% enddocs %}  

{% docs column__loan_next_payment_date %}  
The date the next monthly payment is due for the loan.  

** Business Name: ** Next Payment Date  
** Source: ** loans.next_payment_date  

** Use case: ** Indentify the date the next payment is due for the loans.  
{% enddocs %}  

{% docs column__loan_total_payment_amount %}  
The total amount of payments to made on the loan.  

** Business Name: ** Total Payment Amount  
** Source: ** loans.total_payment  

** Use case: ** Indentify the total payment amount for the loans.  
{% enddocs %}  

{% docs column__loan_status %}  
The status of the loans.  

** Business Name: ** Loan Status  
** Source: ** loans.loan_status  

** Use case: ** Indentify the status of the loan.  

** Values: **  
 - Charged Off — Delinquent loan written off
 - Fully Paid — Loan fully repaid
 - Current — Loan is current
{% enddocs %}  

{% docs column__loan_purpose %}  
The indicated use for loans.  

** Business Name: ** Loan Purpose  
** Source: ** loans.purpose  
** Role: ** Foreign Key to ref.loan_purpose.loan_purpose.  

** Use case: ** Indentify the purpose of the loan.  
{% enddocs %}  

<!-- Borrower Attributes -->
{% docs column__borrower_id %}  
Unique identifier for the borrower.  
  
** Business Name: ** Borrower Id  
** Source: ** loans.member_id  
** Role: ** Primary Key for Borrower records  
  
** Use case: ** Indentify unique borrowers.  
{% enddocs %}  

{% docs column__borrower_type %}  
The type of the borrowers.  
  
** Business Name: ** Borrower Type  
** Source: ** loans.application_type  
  
** Use case: ** Indentify the type of borrower.  

** Values: **  
 - INDIVIDUAL — The borrower is a individual person.
{% enddocs %}  

{% docs column__borrower_state %}  
The state of residence for the borrowers.  
  
** Business Name: ** Borrower State  
** Source: ** loans.address_state  
  
** Use case: ** Indentify the state of residence for the borrower.  

** Values: **  
 - Must be a valid 2 character state code
{% enddocs %}  

{% docs column__borrower_credit_grade %}  
The credit grade for the borrowers.  
  
** Business Name: ** Credit Grade  
** Source: ** loans.grade  
  
** Use case: ** Indentify the credit grade for the borrower.  

** Values: **  
 - A — Exceptional
 - B — Very Good
 - C — Good
 - D — Fair
 - E — Poor
 - F — Very Poor
 - G — High Risk
{% enddocs %}  

{% docs column__borrower_credit_subgrade %}  
The credit subgrade of the borrowers.

** Business Name: ** Credit Subgrade  
** Source: ** loans.subgrade  
  
** Use case: ** Indentify the credit subgrade for the borrower.  

** Values: **  
 - 1-5 tiers within each credit grade.
{% enddocs %}  

{% docs column__borrower_last_credit_report_date %}  
The date of the last credit report pull for the borrowers.

** Business Name: ** Last Credit Report Date  
** Source: ** loans.last_credit_pull_date  
  
** Use case: ** Indentify the date of the last credit report pull for the borrower.  
{% enddocs %}  

{% docs column__borrower_annual_income %}  
The annual income for the borrowers.

** Business Name: ** Annual Income  
** Source: ** loans.annual_income  
  
** Use case: ** Indentify the date of the last credit report pull for the borrower.  
{% enddocs %}  

{% docs column__borrower_debt_to_income %}  
The debt-to-income ratio for the borrowers.

** Business Name: ** Debt-to-Income  
** Source: ** loans.dti  
  
** Use case: ** Indentify the ratio of debt to income for the borrower.  
{% enddocs %}  

{% docs column__borrower_total_accounts %}  
The total number of accounts for the borrowers.

** Business Name: ** Total Accounts  
** Source: ** loans.total_acc  
  
** Use case: ** Indentify the total number of accounts for the borrower.  
{% enddocs %}  

{% docs column__borrower_employment_tenure %}  
The length of time of current employment for the borrowers.

** Business Name: ** Employment Tenure  
** Source: ** loans.emp_length  
  
** Use case: ** Indentify the length of time of current employment for the borrower.  
{% enddocs %}  

{% docs column__borrower_employment_title %}  
The current employment title for the borrowers.

** Business Name: ** Employment Title  
** Source: ** loans.emp_title  
  
** Use case: ** Indentify the employment title for the borrower.  
{% enddocs %}  

{% docs column__borrower_residence_status %}  
The situation of the residence for the borrowers.

** Business Name: ** Residence Status  
** Source: ** loans.home_ownership  
  
** Use case: ** Indentify the residence situation for the borrower.  

** Values: **  
 - MORTGAGE — Pays a mortgage on current residence.  
 - NONE — Unkown residence situation.  
 - OTHER —  Other residence situation.
 - OWN — Owns current residence.
 - RENT — Rents current residence.
{% enddocs %}  

{% docs column__borrower_verification_status %}  
The status of verification of information for the borrowers.

** Business Name: ** Verification Status  
** Source: ** loans.verification_status  
  
** Use case: ** Indentify the information verification status for the borrower.  
{% enddocs %}  
