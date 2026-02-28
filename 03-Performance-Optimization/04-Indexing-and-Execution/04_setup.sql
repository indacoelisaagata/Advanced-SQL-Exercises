/* * SETUP FILE: 04_setup.sql
 * PROJECT: Performance Tuning & Indexing
 * TARGET QUERY FILE: 04_indexing_and_execution_plan.sql
 * DESCRIPTION: Initializes a 'logs' table with a significant dataset to test EXPLAIN plans.
 * AUTHOR: Elisa Agata Indaco
 */

-- Cleanup
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS logs;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: logs
CREATE TABLE logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    log_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- POPULATING DATA (Using a Cross Join to generate rows quickly)
-- This creates 1000 sample logs with randomized user_ids
INSERT INTO logs (user_id, log_message)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 100
)
SELECT 
    FLOOR(1 + (RAND() * 100)), -- Random user_id between 1 and 100
    CONCAT('Log entry number ', s.n, ' for system health check.')
FROM seq s
CROSS JOIN (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 
            UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) AS multiplier;

/* * PERFORMANCE NOTE:
 * We have populated the table with 1,000 rows. In a real-world scenario with 
 * millions of rows, the difference between a Full Table Scan and an Index 
 * would be measured in seconds vs milliseconds.
 */
