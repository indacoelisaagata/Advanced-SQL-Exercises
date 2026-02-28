/* * PROJECT: Finance Portfolio Analytics
 * SETUP SCRIPT: 06_setup.sql
 * GOAL: Track asset positions and prevent illegal transactions (Short Selling Protection).
 * CONCEPTS: Data Integrity, Conditional Aggregation, and Database Triggers.
 * AUTHOR: Elisa Agata Indaco
 *
 * DATABASE SCHEMA:
 * - Assets (asset_id, ticker, asset_name)
 * - MarketPrices (ticker, current_price, last_update)
 * - Transactions (transaction_id, ticker, transaction_type, quantity, price, date)
 */

-- 1. SECURITY LAYER: TRANSACTION VALIDATION TRIGGER
DELIMITER //

CREATE TRIGGER Before_Transaction_Insert
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE total_owned DECIMAL(10,4);

    SELECT IFNULL(SUM(CASE WHEN transaction_type = 'BUY' THEN quantity ELSE -quantity END), 0)
    INTO total_owned
    FROM Transactions
    WHERE ticker = NEW.ticker;

    IF NEW.transaction_type = 'SELL' AND NEW.quantity > total_owned THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'INSUFFICIENT FUNDS: Cannot sell more than current balance.';
    END IF;
END //

DELIMITER ;

-- 2. ANALYTICS QUERY: UNREALIZED PROFIT & LOSS (P&L)
WITH PortfolioSummary AS (
    SELECT 
        ticker,
        SUM(CASE WHEN transaction_type = 'BUY' THEN quantity ELSE -quantity END) AS total_quantity,
        SUM(CASE WHEN transaction_type = 'BUY' THEN quantity * price_per_unit ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN transaction_type = 'BUY' THEN quantity ELSE 0 END), 0) AS avg_buy_price
    FROM Transactions
    GROUP BY ticker
)
SELECT 
    ps.ticker,
    ps.total_quantity,
    ps.avg_buy_price AS cost_basis,
    mp.current_price AS market_price,
    (ps.total_quantity * mp.current_price) AS market_value,
    ((mp.current_price - ps.avg_buy_price) * ps.total_quantity) AS unrealized_pnl,
    (((mp.current_price - ps.avg_buy_price) / ps.avg_buy_price) * 100) AS pnl_percentage
FROM PortfolioSummary ps
JOIN MarketPrices mp ON ps.ticker = mp.ticker
WHERE ps.total_quantity > 0;
