# AdventureWorks Data Warehouse Project

Building a dimensional data warehouse from AdventureWorks OLTP database using star schema design and Kimball methodology.

## 📊 Project Overview
- **Source**: AdventureWorks2025 OLTP (Normalized)
- **Target**: AdventureWorksDW (Star Schema)
- **Tools**: SQL Server 2025, SSMS, T-SQL
- **Methodology**: Kimball Dimensional Modeling

## 🎯 Business Process
Sales analytics with focus on:
- Sales performance by product, customer, territory
- Time-series analysis (daily/monthly/quarterly)
- Sales person and territory performance tracking

## 📐 Star Schema
**Fact Table**: FactSales (121K+ rows)
- Grain: One row per sales order line item
- 6 measures, 8 dimension keys

**Dimensions**: 7 tables
- DimDate, DimProduct, DimCustomer, DimSalesPerson, DimTerritory, DimCreditCard, DimShipMethod

## 🗂️ Repository Structure
```
01-source-analysis/       # OLTP exploration queries
02-dimensional-design/    # Star schema design docs
03-ddl/                   # Table creation scripts
04-etl/                   # Data load scripts
05-validation/            # Data quality checks
06-documentation/         # Project docs
```

## ✅ Validation
- Row count reconciliation passed
- Referential integrity verified
- Business logic validated
- Aggregation accuracy confirmed

## 🚀 How to Run
1. Restore `AdventureWorks2025.bak` 
2. Run DDL scripts (`03-ddl/`)
3. Run ETL scripts (`04-etl/`)
4. Validate (`05-validation/`)

## 📚 Skills Demonstrated
- Dimensional modeling
- ETL development
- Data quality validation
- Git version control

---
**Author**: Vignesh
**Date**: December 2025