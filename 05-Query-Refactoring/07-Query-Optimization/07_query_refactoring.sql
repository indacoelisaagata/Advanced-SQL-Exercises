/* * PROJECT: Advanced SQL Portfolio - Optimization Refactoring
 * TOPIC: Code Quality & Execution Efficiency
 * GOAL: Refactor a subquery-heavy script into a high-performance CTE solution.
 * TECHNIQUE: CTE Materialization vs Nested Subqueries.
 * SETUP SCRIPT: 07_setup.sql
 * AUTHOR: Elisa Agata Indaco
 *
 * DATABASE SCHEMA:
 * - customer (customer_id, first_name, last_name)
 * - payment (payment_id, customer_id, amount)
 */

/*
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id 
    FROM payment 
    GROUP BY customer_id 
    HAVING SUM(amount) > (
        SELECT AVG(total_spent) 
        FROM (SELECT SUM(amount) as total_spent FROM payment GROUP BY customer_id) as sub
    )
);
*/

-- ---------------------------------------------------------
-- APPROACH 2: THE "ENGINEERED" WAY (Optimized)
-- Using Common Table Expressions (CTEs) to pre-calculate 
-- metrics and improve the execution plan.
-- ---------------------------------------------------------

-- Step 1: Aggregate total spending per customer once.
WITH CustomerSpending AS (
    SELECT 
        customer_id, 
        SUM(amount) AS total_paid
    FROM payment
    GROUP BY customer_id
),
-- Step 2: Calculate the global average from the aggregated data.
-- This value is materialized and reused, avoiding redundant calculations.
GlobalAverage AS (
    SELECT AVG(total_paid) AS avg_threshold 
    FROM CustomerSpending
)
-- Step 3: Final Join to retrieve customer details.
-- JOINs are generally more efficient than 'WHERE IN' for large datasets.
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    cs.total_paid
FROM customer c
JOIN CustomerSpending cs ON c.customer_id = cs.customer_id
CROSS JOIN GlobalAverage ga
WHERE cs.total_paid > ga.avg_threshold
ORDER BY cs.total_paid DESC;

/* * PERFORMANCE ANALYSIS:
 * 1. Materialization: The CTE structure allows the SQL Optimizer to 
 * create a temporary result set, reducing the complexity from O(N^2) to O(N).
 * 2. Readability: Breaking down the logic into 'CustomerSpending' and 
 * 'GlobalAverage' makes the code easier to audit and debug.
 * 3. Execution Plan: Using a CROSS JOIN with a single-row CTE (GlobalAverage) 
 * is a high-performance pattern for threshold filtering.
 */
