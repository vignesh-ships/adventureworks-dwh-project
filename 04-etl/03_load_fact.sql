-- Load Fact Table
-- Date: 2025-12-27
-- Purpose: Load sales transactions with dimension surrogate keys

USE AdventureWorksDW;
GO

INSERT INTO FactSales (
    ProductKey,
    CustomerKey,
    SalesPersonKey,
    TerritoryKey,
    OrderDateKey,
    ShipDateKey,
    CreditCardKey,
    ShipMethodKey,
    SalesOrderNumber,
    SalesOrderLineNumber,
    OrderQuantity,
    UnitPrice,
    UnitPriceDiscount,
    LineTotal,
    TaxAmt,
    Freight
)
SELECT 
    dp.ProductKey,
    dc.CustomerKey,
    dsp.SalesPersonKey,
    dt.TerritoryKey,
    CAST(FORMAT(soh.OrderDate, 'yyyyMMdd') AS INT) AS OrderDateKey,
    CAST(FORMAT(soh.ShipDate, 'yyyyMMdd') AS INT) AS ShipDateKey,
    dcc.CreditCardKey,
    dsm.ShipMethodKey,
    soh.SalesOrderNumber,
    ROW_NUMBER() OVER (PARTITION BY soh.SalesOrderID ORDER BY sod.SalesOrderDetailID) AS SalesOrderLineNumber,
    sod.OrderQty AS OrderQuantity,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.LineTotal,
    soh.TaxAmt / COUNT(*) OVER (PARTITION BY soh.SalesOrderID) AS TaxAmt,  -- Allocate tax proportionally
    soh.Freight / COUNT(*) OVER (PARTITION BY soh.SalesOrderID) AS Freight  -- Allocate freight proportionally
FROM AdventureWorks2025.Sales.SalesOrderDetail sod
INNER JOIN AdventureWorks2025.Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN DimProduct dp ON sod.ProductID = dp.ProductID AND dp.IsCurrent = 1
INNER JOIN DimCustomer dc ON soh.CustomerID = dc.CustomerID
LEFT JOIN DimSalesPerson dsp ON soh.SalesPersonID = dsp.SalesPersonID
INNER JOIN DimTerritory dt ON soh.TerritoryID = dt.TerritoryID
LEFT JOIN DimCreditCard dcc ON soh.CreditCardID = dcc.CreditCardID
INNER JOIN DimShipMethod dsm ON soh.ShipMethodID = dsm.ShipMethodID
WHERE soh.OrderDate IS NOT NULL 
  AND soh.ShipDate IS NOT NULL;

PRINT 'FactSales loaded: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';

-- Verification
SELECT 
    COUNT(*) AS TotalRows,
    SUM(LineTotal) AS TotalSales,
    MIN(OrderDateKey) AS FirstOrderDate,
    MAX(OrderDateKey) AS LastOrderDate
FROM FactSales;

GO