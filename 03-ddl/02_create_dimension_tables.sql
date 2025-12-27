-- Create Dimension Tables
-- Date: 2025-12-27

USE AdventureWorksDW;
GO

-- DimDate
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    Day INT NOT NULL,
    MonthName VARCHAR(10) NOT NULL,
    DayName VARCHAR(10) NOT NULL,
    DayOfWeek INT NOT NULL,
    IsWeekend BIT NOT NULL,
    IsHoliday BIT NOT NULL DEFAULT 0
);

-- DimProduct
CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,  -- Natural Key
    ProductName NVARCHAR(50) NOT NULL,
    ProductNumber NVARCHAR(25) NOT NULL,
    Color NVARCHAR(15) NULL,
    Size NVARCHAR(5) NULL,
    Weight DECIMAL(8,2) NULL,
    StandardCost MONEY NOT NULL,
    ListPrice MONEY NOT NULL,
    SubcategoryName NVARCHAR(50) NULL,
    CategoryName NVARCHAR(50) NULL,
    EffectiveDate DATE NOT NULL,
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1
);

-- DimCustomer
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,  -- Natural Key
    PersonType NVARCHAR(2) NULL,
    FirstName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NULL,
    EmailAddress NVARCHAR(50) NULL,
    PhoneNumber NVARCHAR(25) NULL
);

-- DimSalesPerson
CREATE TABLE DimSalesPerson (
    SalesPersonKey INT IDENTITY(1,1) PRIMARY KEY,
    SalesPersonID INT NOT NULL,  -- Natural Key
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    EmailAddress NVARCHAR(50) NULL,
    SalesQuota MONEY NULL,
    Bonus MONEY NULL,
    CommissionPct DECIMAL(5,2) NULL
);

-- DimTerritory
CREATE TABLE DimTerritory (
    TerritoryKey INT IDENTITY(1,1) PRIMARY KEY,
    TerritoryID INT NOT NULL,  -- Natural Key
    TerritoryName NVARCHAR(50) NOT NULL,
    CountryRegionCode NVARCHAR(3) NOT NULL,
    TerritoryGroup NVARCHAR(50) NOT NULL
);

-- DimCreditCard
CREATE TABLE DimCreditCard (
    CreditCardKey INT IDENTITY(1,1) PRIMARY KEY,
    CreditCardID INT NOT NULL,  -- Natural Key
    CardType NVARCHAR(50) NOT NULL,
    CardNumberMasked NVARCHAR(25) NOT NULL
);

-- DimShipMethod
CREATE TABLE DimShipMethod (
    ShipMethodKey INT IDENTITY(1,1) PRIMARY KEY,
    ShipMethodID INT NOT NULL,  -- Natural Key
    ShipMethodName NVARCHAR(50) NOT NULL,
    ShipBase MONEY NOT NULL,
    ShipRate MONEY NOT NULL
);

PRINT 'Dimension tables created successfully';
GO