-- Load Dimension Tables from OLTP
-- Date: 2025-12-27

USE AdventureWorksDW;
GO

-- 1. Load DimProduct (SCD Type 2)
INSERT INTO DimProduct (
    ProductID,
    ProductName,
    ProductNumber,
    Color,
    Size,
    Weight,
    StandardCost,
    ListPrice,
    SubcategoryName,
    CategoryName,
    EffectiveDate,
    EndDate,
    IsCurrent
)
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    p.Color,
    p.Size,
    p.Weight,
    p.StandardCost,
    p.ListPrice,
    ps.Name AS SubcategoryName,
    pc.Name AS CategoryName,
    CAST('2022-01-01' AS DATE) AS EffectiveDate,
    NULL AS EndDate,
    1 AS IsCurrent
FROM AdventureWorks2025.Production.Product p
LEFT JOIN AdventureWorks2025.Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN AdventureWorks2025.Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID;

PRINT 'DimProduct loaded: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- 2. Load DimCustomer
INSERT INTO DimCustomer (
    CustomerID,
    PersonType,
    FirstName,
    LastName,
    EmailAddress,
    PhoneNumber
)
SELECT 
    c.CustomerID,
    p.PersonType,
    p.FirstName,
    p.LastName,
    e.EmailAddress,
    ph.PhoneNumber
FROM AdventureWorks2025.Sales.Customer c
LEFT JOIN AdventureWorks2025.Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN AdventureWorks2025.Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
LEFT JOIN AdventureWorks2025.Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID;

PRINT 'DimCustomer loaded: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- 3. Load DimSalesPerson
INSERT INTO DimSalesPerson (
    SalesPersonID,
    FirstName,
    LastName,
    EmailAddress,
    SalesQuota,
    Bonus,
    CommissionPct
)
SELECT 
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    e.EmailAddress,
    sp.SalesQuota,
    sp.Bonus,
    sp.CommissionPct
FROM AdventureWorks2025.Sales.SalesPerson sp
INNER JOIN AdventureWorks2025.Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
LEFT JOIN AdventureWorks2025.Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID;

PRINT 'DimSalesPerson loaded: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- 4. Load DimTerritory
INSERT INTO DimTerritory (
    TerritoryID,
    TerritoryName,
    CountryRegionCode,
    TerritoryGroup
)
SELECT 
    TerritoryID,
    Name AS TerritoryName,
    CountryRegionCode,
    [Group] AS TerritoryGroup
FROM AdventureWorks2025.Sales.SalesTerritory;

PRINT 'DimTerritory loaded: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- 5. Load DimCreditCard
INSERT INTO DimCreditCard (
    CreditCardID,
    CardType,
    CardNumberMasked
)
SELECT 
    CreditCardID,
    CardType,
    'XXXX-XXXX-XXXX-' + RIGHT(CardNumber, 4) AS CardNumberMasked
FROM AdventureWorks2025.Sales.CreditCard;

PRINT 'DimCreditCard loaded: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- 6. Load DimShipMethod
INSERT INTO DimShipMethod (
    ShipMethodID,
    ShipMethodName,
    ShipBase,
    ShipRate
)
SELECT 
    ShipMethodID,
    Name AS ShipMethodName,
    ShipBase,
    ShipRate
FROM AdventureWorks2025.Purchasing.ShipMethod;

PRINT 'DimShipMethod loaded: ' + CAST(@@ROWCOUNT AS VARCHAR);

GO