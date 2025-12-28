-- Data Validation Checks
-- Date: 2025-12-27
-- Purpose: Validate ETL accuracy and data quality

USE AdventureWorksDW;
GO

PRINT '========================================';
PRINT '1. ROW COUNT RECONCILIATION';
PRINT '========================================';

-- Source vs Target row counts
SELECT 'SalesOrderDetail (Source)' AS TableName, COUNT(*) AS [RowCount]
FROM AdventureWorks2025.Sales.SalesOrderDetail
UNION ALL
SELECT 'FactSales (Target)', COUNT(*)
FROM FactSales;

PRINT '';
PRINT '========================================';
PRINT '2. NULL CHECKS - Critical Columns';
PRINT '========================================';

-- Check for NULLs in important fact measures
SELECT 
    'FactSales' AS TableName,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS NullProductKey,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END) AS NullCustomerKey,
    SUM(CASE WHEN OrderDateKey IS NULL THEN 1 ELSE 0 END) AS NullOrderDateKey,
    SUM(CASE WHEN LineTotal IS NULL THEN 1 ELSE 0 END) AS NullLineTotal
FROM FactSales;

PRINT '';
PRINT '========================================';
PRINT '3. REFERENTIAL INTEGRITY - Orphan Records';
PRINT '========================================';

-- Check for fact records without matching dimension (should be 0)
SELECT 'Orphan ProductKey' AS Issue, COUNT(*) AS OrphanCount
FROM FactSales f
WHERE NOT EXISTS (SELECT 1 FROM DimProduct d WHERE f.ProductKey = d.ProductKey)
UNION ALL
SELECT 'Orphan CustomerKey', COUNT(*)
FROM FactSales f
WHERE NOT EXISTS (SELECT 1 FROM DimCustomer d WHERE f.CustomerKey = d.CustomerKey)
UNION ALL
SELECT 'Orphan OrderDateKey', COUNT(*)
FROM FactSales f
WHERE NOT EXISTS (SELECT 1 FROM DimDate d WHERE f.OrderDateKey = d.DateKey);

PRINT '';
PRINT '========================================';
PRINT '4. BUSINESS LOGIC VALIDATION';
PRINT '========================================';

-- Check for negative amounts or quantities
SELECT 
    'Negative Values' AS Issue,
    SUM(CASE WHEN OrderQuantity < 0 THEN 1 ELSE 0 END) AS NegativeQuantity,
    SUM(CASE WHEN UnitPrice < 0 THEN 1 ELSE 0 END) AS NegativePrice,
    SUM(CASE WHEN LineTotal < 0 THEN 1 ELSE 0 END) AS NegativeLineTotal
FROM FactSales;

-- Check for future dates
SELECT 
    'Future Dates' AS Issue,
    COUNT(*) AS FutureDateCount
FROM FactSales
WHERE OrderDateKey > CAST(FORMAT(GETDATE(), 'yyyyMMdd') AS INT);

PRINT '';
PRINT '========================================';
PRINT '5. AGGREGATION VALIDATION';
PRINT '========================================';

-- Compare total sales: Source vs Target
SELECT 'Source (SalesOrderDetail)' AS Source, SUM(LineTotal) AS TotalSales
FROM AdventureWorks2025.Sales.SalesOrderDetail
UNION ALL
SELECT 'Target (FactSales)', SUM(LineTotal)
FROM FactSales;

PRINT '';
PRINT 'Validation Complete!';
GO