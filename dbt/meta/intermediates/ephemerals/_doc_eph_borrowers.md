{% docs model__eph_borrowers %}  
Ephemeral model for Borrower data.  
Separates Borrower attribues from Loan attribues.
Employs star schema methodology.

** Source: ** stg_loans  
** Grain: ** One record per borrower.  
{% enddocs %}  
