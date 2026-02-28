/* * PROJECT: Advanced SQL Portfolio
 * TOPIC: Performance Tuning & Indexing
 * GOAL: Demonstrate the impact of Indexes on Query Execution
 * SETUP SCRIPT: 04_setup.sql
 * TECHNIQUE: EXPLAIN Statement & B-Tree Indexing
 * AUTHOR: Elisa Agata Indaco
 *
 * DATABASE SCHEMA:
 * - logs (log_id, user_id, log_message, created_at)
 */

-- Step 1: Analyze a query WITHOUT an index
-- This will likely result in a "Full Table Scan" (type: ALL)
EXPLAIN SELECT * FROM logs WHERE user_id = 42;

-- Step 2: Create a B-Tree Index on the filtered column
CREATE INDEX idx_user_id ON logs(user_id);

-- Step 3: Analyze the query AGAIN WITH the index
-- Now the execution plan should show "ref" or "range" instead of "ALL"
EXPLAIN SELECT * FROM logs WHERE user_id = 42;

/* * ENGINEERING NOTES:
 * 1. EXPLAIN Command: Essential for identifying bottlenecks. It shows how 
 * the MySQL Optimizer intends to execute the query.
 * 2. Full Table Scan (ALL): The database reads every single row on disk. 
 * Very inefficient for large tables.
 * 3. Index Lookup (ref/range): The database uses a B-Tree structure to jump 
 * directly to the relevant data, reducing O(N) to O(log N) complexity.
 * 4. Trade-off: While indexes speed up READS (SELECT), they slightly slow down 
 * WRITES (INSERT/UPDATE) because the index must be updated too.
 */
