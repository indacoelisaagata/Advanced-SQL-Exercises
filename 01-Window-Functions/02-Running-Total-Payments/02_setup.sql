/* * SETUP FILE: 02_setup.sql
 * PROJECT: Time Series Analysis - Running Total Payments
 * TARGET QUERY FILE: 02_running_total_payments.sql
 * DESCRIPTION: Initializes the environment and populates transactional data.
 * AUTHOR: Elisa Agata Indaco
 */

-- Cleanup for re-runnability
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS payment;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: payment
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL
);

-- POPULATING DATA
-- Simulating a week of sales with different amounts per day
INSERT INTO payment (customer_id, amount, payment_date) VALUES 
(101, 50.00,  '2024-01-01'),
(102, 25.50,  '2024-01-01'), -- Total Jan 01: 75.50
(103, 100.00, '2024-01-02'), -- Total Jan 02: 100.00
(104, 45.00,  '2024-01-03'),
(105, 55.00,  '2024-01-03'), -- Total Jan 03: 100.00
(101, 200.00, '2024-01-04'), -- Total Jan 04: 200.00
(106, 10.00,  '2024-01-05'), -- Total Jan 05: 10.00
(102, 80.00,  '2024-01-06'), -- Total Jan 06: 80.00
(107, 150.00, '2024-01-07'); -- Total Jan 07: 150.00

/* * DATA NOTES:
 * The data is designed to show multiple transactions on the same day 
 * (Jan 01 and Jan 03) to test the CTE's aggregation logic before 
 * applying the Window Function.
 */
