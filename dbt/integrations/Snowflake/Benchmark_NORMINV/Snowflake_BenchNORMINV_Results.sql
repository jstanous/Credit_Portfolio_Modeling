USE ROLE SYSADMIN;
USE DATABASE CREDIT_PORTFOLIO;
USE SCHEMA UDF;

SELECT 
    query_id,
    query_text,
    start_time,
    end_time,
    total_elapsed_time/1000 AS duration_seconds,
    warehouse_name
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY(
    END_TIME_RANGE_START => DATEADD('hour', -1, CURRENT_TIMESTAMP()),
    RESULT_LIMIT => 200
))
WHERE user_name = CURRENT_USER()
  AND query_text LIKE 'UPDATE BENCH_NORMINV_%'
ORDER BY start_time;


SELECT *
  FROM BENCH_NORMINV_1M;