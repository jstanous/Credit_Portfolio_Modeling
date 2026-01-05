/*===========================================================================================
  Artifact:     NORMINV Precomputed Lookup Table (6‑Decimal Precision)
  Context:      Basel IRB – Statistical Foundations (Vasicek Model Components)
  Purpose:      Generate a high‑precision, precomputed lookup table for Φ⁻¹(p) (NORMINV)
                using Python UDF accuracy with SQL‑native scalability.
  Overview:
    This script materializes a 6‑decimal PD grid (0.000001 → 0.999999) and computes the
    corresponding inverse standard normal quantile Φ⁻¹(p) using the authoritative Python
    UDF implementation (scipy.stats.norm.ppf). The resulting table provides a deterministic,
    auditable, and high‑performance lookup structure for downstream RW calculations.

  Architectural Rationale:
    • Python UDFs provide mathematically exact quantiles but incur runtime overhead when
      executed row‑by‑row in production workloads.
    • SQL lookup tables eliminate runtime Python execution, enabling scalable joins against
      large exposure datasets without approximation error.
    • A 6‑decimal grid (999,999 rows) balances regulatory precision with Snowflake’s ability
      to broadcast and cache small dimension tables efficiently.
    • This artifact supports consultability: all quantile values are fixed, reviewable, and
      reproducible from a single controlled generation script.

  Performance Notes:
    • Table generation completes in ~20–25 seconds on a standard warehouse due to Snowflake’s
      vectorized GENERATOR and batched Python UDF execution.
    • Downstream RW calculations using this table operate entirely in SQL and scale linearly
      with exposure volume.
    • This pattern cleanly separates “statistical truth generation” (Python) from “production
      execution” (SQL), improving both governance and performance.

  Inputs:
    • None (synthetic PD grid generated via SEQ4()).

  Outputs:
    • REF.NORMINV
        p          NUMBER(10,6)   – Probability value
        norminv    FLOAT          – Φ⁻¹(p) computed via Python UDF

  Usage:
    Join on PD rounded to 6 decimals, or use range‑based matching for tail‑sensitive models.

===========================================================================================*/
USE ROLE SYSADMIN;
USE WAREHOUSE DBT_WH;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA REF;

CREATE TABLE NORMINV AS
      (SELECT (ROW_NUMBER() OVER (ORDER BY SEQ4())) * 0.000001 AS p
             ,UTIL_DB.PUBLIC.NORMINV(p) NORMINV
         FROM TABLE(GENERATOR(ROWCOUNT => 999999)) v
       );
