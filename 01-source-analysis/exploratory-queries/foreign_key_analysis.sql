-- Foreign Key Relationships Analysis
-- Purpose: Identify table relationships and central tables
-- Date: 2025-12-27

SELECT 
    fk.name AS fk_name,
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS child_schema,
    OBJECT_NAME(fk.parent_object_id) AS child_table,
    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS parent_schema,
    OBJECT_NAME(fk.referenced_object_id) AS parent_table,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS child_column,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS parent_column
FROM 
    sys.foreign_keys fk
INNER JOIN 
    sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
ORDER BY 
    child_schema, child_table, parent_schema, parent_table;