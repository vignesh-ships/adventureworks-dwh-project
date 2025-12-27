# Business Process Identification - AdventureWorks

## Identified Business Processes

### 1. Sales Process (Primary)
**Key Tables**: 
- SalesOrderHeader, SalesOrderDetail
- Customer, SalesPerson, SalesTerritory
- Product, SpecialOffer

**Metrics**:
- Order count, Sales amount
- Customer count, Territory performance
- Product sales, Discount impact

**Grain**: One row per order line item

---

### 2. Purchasing Process
**Key Tables**:
- PurchaseOrderHeader, PurchaseOrderDetail
- Vendor, Product

**Metrics**:
- Purchase amount, Order count
- Vendor performance

**Grain**: One row per purchase line item

---

### 3. Production Process
**Key Tables**:
- WorkOrder, TransactionHistory
- Product, Location

**Metrics**:
- Work order count, Production cost
- Inventory transactions

**Grain**: One row per work order / transaction

---

## Priority for DWH
**Phase 1**: Sales Process (most critical for business)
**Phase 2**: Purchasing Process
**Phase 3**: Production Process