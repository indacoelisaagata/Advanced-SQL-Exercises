/* * SETUP FILE: 03_setup.sql
 * PROJECT: Programmable Logic (Stored Procedures)
 * TARGET QUERY FILE: 03_customer_status_procedure.sql
 * DESCRIPTION: Initializes customer and payment tables to test loyalty tier logic.
 * AUTHOR: Elisa Agata Indaco
 */

-- Cleanup
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS payments, customers;
DROP PROCEDURE IF EXISTS GetCustomerStatus;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Table: payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- POPULATING DATA
INSERT INTO customers (first_name, last_name) VALUES 
('Mario', 'Rossi'),   -- Expected: Platinum (> 300)
('Anna', 'Verdi'),    -- Expected: Gold (100-300)
('Luca', 'Bianchi');  -- Expected: Silver (< 100)

-- Payments for Mario (Total: 350)
INSERT INTO payments (customer_id, amount, payment_date) VALUES 
(1, 150.00, '2024-01-10'), (1, 200.00, '2024-01-15');

-- Payments for Anna (Total: 150)
INSERT INTO payments (customer_id, amount, payment_date) VALUES 
(2, 50.00, '2024-01-12'), (2, 100.00, '2024-01-18');

-- Payments for Luca (Total: 45)
INSERT INTO payments (customer_id, amount, payment_date) VALUES 
(3, 45.00, '2024-01-20');

/* * TEST DATA NOTES:
 * Customer 1 (Mario) -> 350.00 (Platinum)
 * Customer 2 (Anna)  -> 150.00 (Gold)
 * Customer 3 (Luca)  ->  45.00 (Silver)
 */
