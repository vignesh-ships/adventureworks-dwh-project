# Sales Star Schema Design

## Fact Table: FactSales

**Grain**: One row per sales order line item

**Source**: Sales.SalesOrderDetail + Sales.SalesOrderHeader

**Measures** (Quantitative):
- OrderQuantity
- UnitPrice
- UnitPriceDiscount
- LineTotal
- TaxAmt
- Freight (allocated from header)

**Foreign Keys** (Dimension references):
- ProductKey → DimProduct
- CustomerKey → DimCustomer
- SalesPersonKey → DimSalesPerson
- TerritoryKey → DimTerritory
- OrderDateKey → DimDate
- ShipDateKey → DimDate
- CreditCardKey → DimCreditCard
- ShipMethodKey → DimShipMethod

**Degenerate Dimensions** (IDs without separate dimension):
- SalesOrderNumber
- SalesOrderLineNumber

---

## Dimension Tables

### DimProduct
**Source**: Production.Product + ProductSubcategory + ProductCategory
**SCD Type**: Type 2 (track changes)
**Attributes**:
- ProductKey (SK)
- ProductID (NK)
- ProductName
- ProductNumber
- Color, Size, Weight
- StandardCost, ListPrice
- SubcategoryName
- CategoryName
- EffectiveDate, EndDate, IsCurrent

### DimCustomer
**Source**: Sales.Customer + Person.Person + Person.BusinessEntity
**SCD Type**: Type 1 (overwrite)
**Attributes**:
- CustomerKey (SK)
- CustomerID (NK)
- PersonType (Individual/Store)
- FirstName, LastName
- EmailAddress
- PhoneNumber

### DimDate
**Source**: Generated dimension
**Attributes**:
- DateKey (SK) - YYYYMMDD format
- Date
- Year, Quarter, Month, Day
- MonthName, DayName
- IsWeekend, IsHoliday

### DimSalesPerson
**Source**: Sales.SalesPerson + HumanResources.Employee + Person.Person
**SCD Type**: Type 1
**Attributes**:
- SalesPersonKey (SK)
- SalesPersonID (NK)
- FirstName, LastName
- EmailAddress
- SalesQuota
- Bonus, CommissionPct

### DimTerritory
**Source**: Sales.SalesTerritory
**SCD Type**: Type 1
**Attributes**:
- TerritoryKey (SK)
- TerritoryID (NK)
- TerritoryName
- CountryRegionCode
- Group (North America, Europe, Pacific)

### DimCreditCard
**Source**: Sales.CreditCard
**SCD Type**: Type 1
**Attributes**:
- CreditCardKey (SK)
- CreditCardID (NK)
- CardType
- CardNumberMasked (last 4 digits only)

### DimShipMethod
**Source**: Purchasing.ShipMethod
**SCD Type**: Type 1
**Attributes**:
- ShipMethodKey (SK)
- ShipMethodID (NK)
- ShipMethodName
- ShipBase, ShipRate

---

## Design Decisions

1. **Grain**: Line item level - most atomic for analysis
2. **SCD Types**: Product = Type 2 (price/cost changes matter), Others = Type 1
3. **Conformed Dimensions**: DimDate, DimProduct (reusable across fact tables)
4. **Degenerate Dimensions**: Order numbers stay in fact (no separate dimension needed)