/* * PROJECT: Advanced SQL Portfolio - Revenue Tracking
 * TOPIC: Time Series Analysis
 * GOAL: Calculate Daily Revenue and Running Total (Cumulative Sum).
 * TECHNIQUE: Window Functions (SUM() OVER) with Frame Clause.
 * SETUP SCRIPT: 02_setup.sql
 * AUTHOR: Elisa Agata Indaco
 *
 * DATABASE SCHEMA:
 * - payment (payment_id, customer_id, amount, payment_date): 
 * Contains transactional data for all customer payments.
 */

-- Step 1: Aggregate daily revenue using a CTE
WITH DailyRevenue AS (
    SELECT 
        payment_date,
        SUM(amount) AS daily_amount
    FROM payment
    GROUP BY payment_date
)
-- Step 2: Calculate the Running Total using a Window Function
SELECT 
    payment_date,
    daily_amount,
    SUM(daily_amount) OVER (
        ORDER BY payment_date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM DailyRevenue
ORDER BY payment_date;

/* * ENGINEERING NOTES:
 * 1. ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: This frame clause 
 * defines the window from the very first row of the partition 
 * up to the current row.
 * 2. Data Aggregation: We first group by date to have one row per day, 
 * then apply the window function to avoid duplicate entries in the accumulation.
 * 3. Business Value: Essential for monitoring KPI growth over time.
 */
