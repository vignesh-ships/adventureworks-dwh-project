-- Create Data Warehouse Database
-- Date: 2025-12-27

USE master;
GO

-- Drop if exists (for development)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'AdventureWorksDW')
BEGIN
    ALTER DATABASE AdventureWorksDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AdventureWorksDW;
END
GO

-- Create DWH database
CREATE DATABASE AdventureWorksDW;
GO

USE AdventureWorksDW;
GO

PRINT 'AdventureWorksDW database created successfully';