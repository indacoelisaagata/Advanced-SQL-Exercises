/* * SETUP FILE: 06_setup.sql
 * PROJECT: Finance Portfolio Analytics
 * TARGET QUERY FILE: 06_fintrack_sql_engine.sql
 * DESCRIPTION: Initializes assets, prices, and transaction history for portfolio tracking.
 * AUTHOR: Elisa Agata Indaco
 */

-- Cleanup
SET FOREIGN_KEY_CHECKS = 0;
DROP TRIGGER IF EXISTS Before_Transaction_Insert;
DROP TABLE IF EXISTS Transactions, MarketPrices, Assets;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: Assets
CREATE TABLE Assets (
    asset_id INT PRIMARY KEY,
    ticker VARCHAR(10) UNIQUE NOT NULL,
    asset_name VARCHAR(100) NOT NULL
);

-- Table: MarketPrices
CREATE TABLE MarketPrices (
    ticker VARCHAR(10) PRIMARY KEY,
    current_price DECIMAL(10,2) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: Transactions
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    ticker VARCHAR(10) NOT NULL,
    transaction_type ENUM('BUY', 'SELL') NOT NULL,
    quantity DECIMAL(10,4) NOT NULL,
    price_per_unit DECIMAL(10,2) NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (ticker) REFERENCES Assets(ticker)
);

-- POPULATING DATA
INSERT INTO Assets (asset_id, ticker, asset_name) VALUES 
(1, 'AAPL', 'Apple Inc.'),
(2, 'BTC', 'Bitcoin'),
(3, 'TSLA', 'Tesla, Inc.');

-- Current Market Prices (Simulating real-time data)
INSERT INTO MarketPrices (ticker, current_price) VALUES 
('AAPL', 190.00), -- Apple went up
('BTC', 65000.00), -- BTC went up a lot
('TSLA', 170.00); -- Tesla went down

-- Transaction History
INSERT INTO Transactions (ticker, transaction_type, quantity, price_per_unit, transaction_date) VALUES 
('AAPL', 'BUY', 10, 150.00, '2023-01-10'), -- Cost: 1500
('BTC', 'BUY', 0.5, 30000.00, '2023-02-15'), -- Cost: 15000
('TSLA', 'BUY', 20, 250.00, '2023-03-01'), -- Cost: 5000
('AAPL', 'SELL', 2, 180.00, '2023-05-10'); -- Reducing position

/* * TEST DATA NOTES:
 * - AAPL: Avg Buy 150, Market 190 -> Expected Profit.
 * - TSLA: Avg Buy 250, Market 170 -> Expected Loss.
 * - BTC: Avg Buy 30000, Market 65000 -> Significant Profit.
 */
