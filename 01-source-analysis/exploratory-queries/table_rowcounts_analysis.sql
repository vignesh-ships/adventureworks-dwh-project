-- Table Row Counts Analysis
-- Purpose: Identify large transactional tables (potential fact candidates)
-- Date: 2025-12-27

SELECT 
    s.name AS schema_name,
    t.name AS table_name,
    p.rows AS row_count
FROM 
    sys.tables t
INNER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN 
    sys.partitions p ON t.object_id = p.object_id
WHERE 
    p.index_id IN (0, 1)  -- Heap or Clustered Index
    AND s.name NOT IN ('sys', 'INFORMATION_SCHEMA')
ORDER BY 
    p.rows DESC;