/* * SETUP FILE: 07_setup.sql
 * PROJECT: Query Performance Optimization (Refactoring)
 * TARGET QUERY FILE: 07_query_refactoring.sql
 * DESCRIPTION: Initializes customers and payments to demonstrate CTE-based optimization.
 * AUTHOR: Elisa Agata Indaco
 */

-- Cleanup
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS payment, customer;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Table: payment
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- POPULATING DATA
INSERT INTO customer (first_name, last_name) VALUES 
('Alice', 'Wonderland'), -- High Spender
('Bob', 'Builder'),      -- Average Spender
('Charlie', 'Brown'),    -- Low Spender
('Diana', 'Prince');     -- High Spender

-- Payments for Alice (Total: 500)
INSERT INTO payment (customer_id, amount) VALUES (1, 200.00), (1, 300.00);

-- Payments for Bob (Total: 150)
INSERT INTO payment (customer_id, amount) VALUES (2, 75.00), (2, 75.00);

-- Payments for Charlie (Total: 50)
INSERT INTO payment (customer_id, amount) VALUES (3, 50.00);

-- Payments for Diana (Total: 1000)
INSERT INTO payment (customer_id, amount) VALUES (4, 1000.00);

/* * DATA ANALYSIS NOTES:
 * Total overall spent: 1700.00
 * Customers: 4
 * Average per customer: 425.00
 * Expected Results: Only Alice (500) and Diana (1000) should appear.
 */
