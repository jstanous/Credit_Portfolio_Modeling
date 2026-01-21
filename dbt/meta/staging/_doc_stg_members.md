{% docs model__stg_members %}  
Staging model for member data.  
Separates member attributes from loan attributes.
Employs star schema methodology.

** Source: ** credit_portfolio.raw.loans  
** Grain: ** One record per member.  
{% enddocs %}

