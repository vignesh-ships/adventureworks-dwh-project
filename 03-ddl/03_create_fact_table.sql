-- Create Fact Table
-- Date: 2025-12-27

USE AdventureWorksDW;
GO

CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    
    -- Foreign Keys (Dimension References)
    ProductKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    SalesPersonKey INT NULL,
    TerritoryKey INT NOT NULL,
    OrderDateKey INT NOT NULL,
    ShipDateKey INT NOT NULL,
    CreditCardKey INT NULL,
    ShipMethodKey INT NOT NULL,
    
    -- Degenerate Dimensions
    SalesOrderNumber NVARCHAR(25) NOT NULL,
    SalesOrderLineNumber SMALLINT NOT NULL,
    
    -- Measures
    OrderQuantity SMALLINT NOT NULL,
    UnitPrice MONEY NOT NULL,
    UnitPriceDiscount MONEY NOT NULL DEFAULT 0,
    LineTotal NUMERIC(38,6) NOT NULL,
    TaxAmt MONEY NOT NULL DEFAULT 0,
    Freight MONEY NOT NULL DEFAULT 0,
    
    -- Foreign Key Constraints
    CONSTRAINT FK_FactSales_DimProduct FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    CONSTRAINT FK_FactSales_DimCustomer FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT FK_FactSales_DimSalesPerson FOREIGN KEY (SalesPersonKey) REFERENCES DimSalesPerson(SalesPersonKey),
    CONSTRAINT FK_FactSales_DimTerritory FOREIGN KEY (TerritoryKey) REFERENCES DimTerritory(TerritoryKey),
    CONSTRAINT FK_FactSales_DimOrderDate FOREIGN KEY (OrderDateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_FactSales_DimShipDate FOREIGN KEY (ShipDateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_FactSales_DimCreditCard FOREIGN KEY (CreditCardKey) REFERENCES DimCreditCard(CreditCardKey),
    CONSTRAINT FK_FactSales_DimShipMethod FOREIGN KEY (ShipMethodKey) REFERENCES DimShipMethod(ShipMethodKey)
);

PRINT 'Fact table created successfully';
GO