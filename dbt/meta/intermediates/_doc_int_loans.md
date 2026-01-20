{% docs model__int_loans %}  
Intermediate model for Loan data.  
Enriches Loan attributes with Maturity Date.
References Borrower Id as Foreign Key.
Employs star schema methodology.

** Source: ** stg_loans  
** Grain: ** One record per loan.  
{% enddocs %}  

{% docs column__loan_maturity_date %}  
The date of the end of the loans.  

** Business Name: ** Maturity Date  

** Use case: ** Identify the date of maturity for the loan.

** Logic: ** DATEADD(month, loan_term, loan_origination_date)  
{% enddocs %}  
