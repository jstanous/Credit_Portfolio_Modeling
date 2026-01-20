{% docs model\_\_stg\_customers %}  
Staging model for Customer data.  
Separates Customer attributes from Loan attributes.
Employs star schema methodology.

\*\* Source: \*\* credit\_portfolio.raw.loans  
\*\* Grain: \*\* One record per customer.  
{% enddocs %}

