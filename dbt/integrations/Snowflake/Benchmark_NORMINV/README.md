# **Benchmarking Ported NORMINV Function in Snowflake**

*A performance and precision study of inverse normal CDF implementations in Snowflake*  

## Overview

This project benchmarks the performance and numerical behavior of the **inverse standard normal CDF** (commonly known as `NORMINV` or `NORM.INV` in Excel).

Three approaches were implemented in Snowflake:

- **Snowpark Python UDF:** Direct implementation of `scipy.stats.norm.ppf(p)`  
- **Snowflake SQL UDF:** Scalar function that uses SQL to resolve values by querying the precomputed scale‑6 lookup table  
- **Lookup Table:** SQL update process that joins to the precomputed scale‑6 lookup table  

The goals of this sub‑project are to:

- evaluate scalability across different implementation strategies  
- validate numerical precision and identify any cross‑platform drift  
- establish a reproducible, auditable pattern for porting Excel‑style functions into Snowflake  

This work supports the broader **Credit Portfolio Modeling** project, where the Python UDF currently serves as the reference implementation for the Basel III IRB Risk‑Weight calculation.

## Objectives

- Generate 5 tables of **10<sup>{0, 2, 4, 6, 8}</sup> records** with evenly spaced p‑values across (0,1).
- Compute `NORMINV(p)` using:
  - Python UDF  
  - SQL UDF  
  - Lookup Table  
- Compare **performance** across Snowflake implementations, evaluating execution time and scalability as table sizes increase.
- Compare **numeric precision** between Snowflake/Python implementations and Excel as external control.
- Identify the decimal scale at which all implementations reliably match.
- Document architectural patterns for porting Excel-style functions into Snowflake.

## Methodology

### 1. **Dataset Generation**

5 tables of 1, 100, 10K, 1M, and 100M rows were created with evenly spaced p‑values using  
[Snowflake_BenchNORMINV_Setup.sql](./Snowflake_BenchNORMINV_Setup.sql).  
Generated values of 0 and 1 were changed to 0.000001 and 0.999999 respectively, as NORMINV is undefined at these boundaries.

### 2. **Implementations Benchmarked**

Each Snowflake implementation populated its respective column in the generated tables using  
[Snowflake_BenchNORMINV_Updates.sql](./Snowflake_BenchNORMINV_Updates.sql).  

The captured data was used to evaluate numeric precision, while the query results were used to evaluate performance:

| Method | Benchmark Usage |
| - | - |
| **Python UDF** | Baseline numerical reference implementation; used to generate precomputed scale-6 lookup table |
| **SQL UDF** | Evaluates scalability and consistency when executed as a pure SQL function |
| **Lookup Table** | Establishes a baseline for evaluating function performance |
| **Excel** | External control to validate Snowflake Python UDF implementation |

### 3. **Comparison Strategy**  

The 1M records table was used for numerical comparison as all scale-6 input values are represented.  
A tolerance‑based comparison with absolute error thresholds was performed in Excel using:

```excel
=ABS('Excel NORM.INV() value' - 'Python UDF value') < 1E-9
```

## Results

### **Performance comparison: Python, SQL UDF, and Lookup Table**

The three Snowflake implementations exhibited the expected performance hierarchy driven by their execution models:

- **SQL UDF** and **Lookup Table** performed nearly identically across all table sizes.  
  Both approaches benefit from Snowflake’s vectorized execution and warehouse‑level parallelism, and both avoid per‑row Python overhead.  
  The choice between them is therefore driven by control and transparency, not speed.
- **Python UDF** was the slowest implementation due to per‑row Python invocation overhead, though still suitable for reference calculations and low‑volume workloads.

These results reinforce the intended usage pattern: Python for correctness, SQL UDF for encapsulated production compute, and Lookup Table for maximum transparency in regulated environments.

### **Numeric comparison: Python, SQL UDF, and Lookup Table**

Since all three Snowflake implementations ultimately derive from the same SciPy function, no meaningful drift was observed across all rows.

### **Numeric comparison: Excel vs. Python/Snowflake**

Excel’s `NORM.INV()` matched Python/Snowflake `NORMINV()` UDF to the **9th decimal place**, which is consistent with NORMINV approximation models used in Excel versus Python SciPy libraries.

## Architectural Takeaways

- Any deterministic Excel function can be ported to Snowflake using Python to create user-defined functions (UDFs).  
- Python‑based UDFs make excellent reference implementations, being easy to validate and consistent with scientific libraries such as SciPy.  
- Single‑input functions are ideal candidates for SQL‑based lookup patterns using precomputed tables. This approach offers deterministic behavior, full auditability, and regulatory transparency.
- SQL UDFs and Lookup Tables deliver comparable performance, both running efficiently on Snowflake’s compute engine. The choice between them is driven by governance preferences:
  - SQL UDF → encapsulation, versioning, cleaner application code
  - Lookup Table → maximum transparency and inspectability
- Python-based UDF performance should be evaluated independently to determine scalability thresholds.  

## Recommended Pattern for Credit Modeling

| Purpose | Recommended Implemenation |
| - | - |
| **Correctness / Reference** | Python UDF |
| **Production Compute** | SQL UDF |
| **Regulatory Transparency** | Lookup Table |

This pattern mirrors real‑world credit engines used in regulated environments.

## Conclusion

This benchmarking exercise demonstrates that Snowflake, Python, and Excel all compute the inverse normal CDF with extremely high agreement. Differences appear only in the 10th–11th decimal place and are attributable to normal floating‑point and approximation behavior.  

In addition to the precision findings, the performance results highlight clear execution trade‑offs across implementations. SQL UDFs and Lookup Tables delivered nearly identical performance across all table sizes, reflecting Snowflake’s ability to process large datasets efficiently. The choice between them is therefore driven by governance preferences: SQL UDFs offer encapsulation and cleaner application code, while Lookup Tables provide maximum transparency and auditability. Python UDFs—while ideal for correctness—should be evaluated independently to determine their practical scalability thresholds.  

The validated precision supports using the Python implementation as the reference for credit modeling, with SQL UDFs and precomputed lookup tables available for scaling and productionization.

## Final Thoughts

For most of my career working with SQL, I’ve wanted native statistical functions that could support real analytical workloads. That gap has finally narrowed with the availability of Python‑based UDFs in Snowflake. Now that many SQL platforms support embedded Python, there is a genuine opportunity to migrate Excel‑driven analytical processes into scalable, governed, and reproducible systems.  

What used to require workarounds or desktop tooling can now be implemented directly inside the data platform, opening the door to cleaner architectures and more reliable credit‑modeling workflows.
