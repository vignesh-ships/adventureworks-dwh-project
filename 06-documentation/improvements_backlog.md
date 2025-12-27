# Improvements Backlog

## High Priority

### 1. DimProduct - Use Actual Effective Dates
**Current**: Static date '2022-01-01' for all products  
**Improvement**: Use ProductCostHistory and ProductListPriceHistory for actual EffectiveDate/EndDate  
**Benefit**: Accurate historical price/cost tracking  
**Effort**: Medium (complex JOIN with RANK/ROW_NUMBER)  
**File to update**: `04-etl/02_load_dimensions.sql`

### 2. DimTerritory - Add CountryRegionName
**Current**: Only CountryRegionCode stored  
**Improvement**: JOIN Person.CountryRegion to get CountryRegionName  
**Benefit**: More meaningful dimension attribute  
**Effort**: Low  
**Files to update**: 
- `03-ddl/02_create_dimension_tables.sql`
- `04-etl/02_load_dimensions.sql`

### 3. DimCreditCard - Add Expiry Details
**Current**: Only CardType and masked number  
**Improvement**: Add ExpMonth and ExpYear columns  
**Benefit**: Filter expired cards, analyze card lifecycle  
**Effort**: Low  
**Files to update**: 
- `03-ddl/02_create_dimension_tables.sql`
- `04-etl/02_load_dimensions.sql`

## Future Enhancements
- Incremental ETL logic (currently full load)
- Error handling and logging
- ETL orchestration (scheduling)
- Data quality checks