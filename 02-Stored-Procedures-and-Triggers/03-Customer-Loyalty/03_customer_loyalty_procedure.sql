/* * PROJECT: Advanced SQL Portfolio
 * TOPIC: Programmable Logic (Stored Procedures)
 * GOAL: Categorize customers based on their total spending
 * SETUP SCRIPT: 03_setup.sql
 * TECHNIQUE: IN/OUT Parameters, Variables, and IF-THEN-ELSE Logic
 * AUTHOR: Elisa Agata Indaco
 *
 * DATABASE SCHEMA:
 * - customers (customer_id, first_name, last_name)
 * - payments (payment_id, customer_id, amount, payment_date)
 */

-- Preventive Cleanup: Remove the procedure if it already exists to avoid conflicts.
DROP PROCEDURE IF EXISTS GetCustomerStatus;

-- 2. Change Delimiter: Switch from ';' to '//' to allow the use of semicolons inside the procedure body.
DELIMITER //

-- Step 1: Define the Procedure
CREATE PROCEDURE GetCustomerStatus(
    IN p_customer_id INT,
    OUT p_status VARCHAR(20)
)
BEGIN
    DECLARE total_spent DECIMAL(10,2);

    -- Calculate total spent by the customer
    SELECT SUM(amount) INTO total_spent
    FROM payments
    WHERE customer_id = p_customer_id;

    -- Logic to assign status
    IF total_spent > 300 THEN
        SET p_status = 'PLATINUM';
    ELSEIF total_spent BETWEEN 100 AND 300 THEN
        SET p_status = 'GOLD';
    ELSE
        SET p_status = 'SILVER';
    END IF;
END;

-- Restore Delimiter: Reset back to the standard ';' for regular SQL queries.
DELIMITER ;

-- Step 2: How to test the procedure (Usage Example)
-- CALL GetCustomerStatus(1, @current_status);
-- SELECT @current_status AS customer_tier;

/* * ENGINEERING NOTES:
 * 1. Encapsulation: The business logic for "loyalty tiers" stays in the DB, 
 * making it consistent across different apps (Web, Mobile, BI tools).
 * 2. Parameters: 'IN' is the input (ID), 'OUT' is the result variable.
 * 3. Scope: Local variables (total_spent) are only visible inside the BEGIN/END block.
 */
