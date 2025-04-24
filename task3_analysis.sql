
-- 1. Total sales by country
SELECT Country, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Transactions
GROUP BY Country
ORDER BY TotalRevenue DESC;

-- 2. LEFT JOIN to simulate customer-country relation
SELECT t1.InvoiceNo, t1.Description, t1.CustomerID, t2.Country
FROM Transactions t1
LEFT JOIN (
    SELECT DISTINCT CustomerID, Country
    FROM Transactions
) t2 ON t1.CustomerID = t2.CustomerID
LIMIT 100;

-- 3. Subquery for high-spending customers
SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalSpent
FROM Transactions
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Transactions
    GROUP BY CustomerID
    HAVING SUM(Quantity * UnitPrice) > 10000
)
GROUP BY CustomerID;

-- 4. Average order value by customer
SELECT CustomerID, AVG(Quantity * UnitPrice) AS AvgOrderValue
FROM Transactions
GROUP BY CustomerID;

-- 5. Create a view for monthly sales
CREATE VIEW MonthlySales AS
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM Transactions
GROUP BY Month;

-- 6. Create indexes
CREATE INDEX idx_customer_id ON Transactions(CustomerID);
CREATE INDEX idx_invoice_date ON Transactions(InvoiceDate);
