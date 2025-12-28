# AdventureWorks Data Warehouse - Project Summary

## Project Overview
Built a dimensional data warehouse from AdventureWorks OLTP database following Kimball methodology and star schema design principles.

## Architecture
- **Source**: AdventureWorks2025 (OLTP - Normalized)
- **Target**: AdventureWorksDW (Star Schema - Denormalized)
- **ETL Tool**: T-SQL Stored Procedures
- **Database**: SQL Server 2025 Express

## Star Schema Design

### Fact Table
- **FactSales**: 121,317 rows
  - Grain: One row per sales order line item
  - Measures: OrderQuantity, UnitPrice, LineTotal, TaxAmt, Freight
  - 8 dimension foreign keys

### Dimension Tables
1. **DimDate**: 1,461 rows (2022-2025)
2. **DimProduct**: 504 rows (SCD Type 2)
3. **DimCustomer**: 19,820 rows
4. **DimSalesPerson**: 17 rows
5. **DimTerritory**: 10 rows
6. **DimCreditCard**: 19,118 rows
7. **DimShipMethod**: 5 rows

## Key Design Decisions
- **Surrogate Keys**: Used IDENTITY columns for all dimension keys
- **SCD Type 2**: Implemented for DimProduct (price/cost tracking)
- **SCD Type 1**: All other dimensions (overwrite changes)
- **Degenerate Dimensions**: SalesOrderNumber stored in fact table
- **Conformed Dimensions**: DimDate, DimProduct (reusable across facts)

## ETL Process
1. One-time DimDate population (date generator)
2. Dimension loads (full extract from OLTP)
3. Fact load with surrogate key lookups
4. Header-level measures (TaxAmt, Freight) allocated to line items

## Validation Results
✅ Row count reconciliation: 121,317 (Source = Target)  
✅ No NULL values in critical columns  
✅ No orphan records (referential integrity intact)  
✅ No negative values or future dates  
✅ Aggregation match: Total sales validated  

## Repository Structure
```
01-source-analysis/
  - exploratory-queries/
02-dimensional-design/
  - sales_star_schema_design.md
03-ddl/
  - 01_create_database.sql
  - 02_create_dimension_tables.sql
  - 03_create_fact_table.sql
04-etl/
  - 01_load_dimdate.sql
  - 02_load_dimensions.sql
  - 03_load_fact.sql
05-validation/
  - 01_data_validation.sql
06-documentation/
  - improvements_backlog.md
  - project_summary.md
```

## Skills Demonstrated
- Star schema dimensional modeling
- OLTP to DWH transformation
- T-SQL ETL development
- Data quality validation
- Git version control
- Documentation best practices

## Future Enhancements
See `improvements_backlog.md`