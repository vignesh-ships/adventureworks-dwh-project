-- Populate DimDate
-- Date: 2025-12-27
-- Purpose: Generate date dimension for 2022-2025 (AdventureWorks date range)

USE AdventureWorksDW;
GO

-- Clear existing data
DELETE FROM DimDate;
GO

-- Declare variables
DECLARE @StartDate DATE = '2022-01-01';
DECLARE @EndDate DATE = '2025-12-31';

-- Generate dates
WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (
        DateKey,
        FullDate,
        Year,
        Quarter,
        Month,
        Day,
        MonthName,
        DayName,
        DayOfWeek,
        IsWeekend
    )
    VALUES (
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),  -- DateKey: 20110101
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DAY(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        DATEPART(WEEKDAY, @StartDate),
        CASE WHEN DATEPART(WEEKDAY, @StartDate) IN (1, 7) THEN 1 ELSE 0 END
    );
    
    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END

-- Verify
SELECT 
    COUNT(*) AS TotalRows,
    MIN(FullDate) AS StartDate,
    MAX(FullDate) AS EndDate
FROM DimDate;

PRINT 'DimDate loaded successfully';
GO