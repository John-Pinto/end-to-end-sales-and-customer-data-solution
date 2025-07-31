/*
================================================
Create Database and Schema
================================================
Script Purpose:
	This script checks for the "DataWarehouse" database, if it exists then it 
	drops the database and recreates the database. Along with the database, it 
	creates three schema bronze, silver and gold.

Warning:
	Running this script can cause permanent deletion of data from the existing 
	database "DataWarehouse".
	Proceed with caution and ensure you have proper backup before running the script.
*/

USE master;
GO

-- Droping and recreating the database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Creating the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schema for all the stages
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO