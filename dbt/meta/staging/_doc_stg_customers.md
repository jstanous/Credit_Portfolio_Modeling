{% docs model__stg_customers %}  
Staging model for Customer data.  
Separates Customer attributes from Loan attributes.
Employs star schema methodology.

** Source: ** credit_portfolio.raw.loans  
** Grain: ** One record per customer.  
{% enddocs %}

