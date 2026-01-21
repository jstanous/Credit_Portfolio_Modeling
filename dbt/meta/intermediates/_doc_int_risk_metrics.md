{% docs model__int_risk_metrics %}  
Intermediate model for Loan Risk Metrics data.  
Enriches Loan data with risk metrics.
Employs star schema methodology.

** Source: ** stg_loans, stg_members  
** Grain: ** One record per loan.  
{% enddocs %}  

{% docs column__pd %}  
The percentage that represents the likelyhood of loan default.  

** Business Name: ** Probability of Default  

** Use case: ** Identify the default probability for the loan.  

** Logic: ** Jinja Macro: `get_PD('member_credit_subgrade')`  
{% enddocs %}  
