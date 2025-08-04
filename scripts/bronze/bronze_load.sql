/*
=====================================================================
Bronze Layer: Load Script - Data Loading From Source
=====================================================================
Script Purpose:
	This script uses stored procedure to load the data into the 
	bronze schema from external CSV files and performs following 
	actions:
		- Truncates the table before loading data.
		- Uses bulk insert method to load data in the table.

Parameters:
	None.
		This stored procedure does not accepts and returns no values.

Usage Example:
	EXEC bronze.bronze_load;
=====================================================================
*/
USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.bronze_load AS
BEGIN
	BEGIN TRY
		-- Variables for calculating duration while loading data
		DECLARE 
			@start_time DATETIME, 
			@end_time DATETIME, 
			@batch_start_time DATETIME, 
			@batch_end_time DATETIME;

		-- Two operation are performed for 6 tables, 3 tables each for CRM and ERP
		-- first the table is truncated and next bulk insert is performed
		SET @batch_start_time = GETDATE();
		PRINT '====================================================';
		PRINT 'BRONZE LAYER: DATA LOADING';
		PRINT '====================================================';

		PRINT '----------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		
		PRINT '>> Inserting Data Into Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\projects_and_learning\github\github_repo\end-to-end-sales-and-customer-data-solution\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Data Insert Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\projects_and_learning\github\github_repo\end-to-end-sales-and-customer-data-solution\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Data Insert Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into Table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\projects_and_learning\github\github_repo\end-to-end-sales-and-customer-data-solution\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Data Insert Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '--------------------';

		PRINT '----------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into Table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\projects_and_learning\github\github_repo\end-to-end-sales-and-customer-data-solution\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Data Insert Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into Table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\projects_and_learning\github\github_repo\end-to-end-sales-and-customer-data-solution\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Data Insert Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '--------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		
		PRINT '>> Inserting Data Into Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\projects_and_learning\github\github_repo\end-to-end-sales-and-customer-data-solution\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Data Insert Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '--------------------';

		SET @batch_end_time = GETDATE();
		PRINT '====================================================';
		PRINT 'Bronze Layer Data Loading is Completed';
		PRINT 'Total Duration: ' + CAST(DATEDIFF(millisecond, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' milliseconds';
		PRINT '====================================================';
	END TRY
	
	BEGIN CATCH
		PRINT '====================================================';
		PRINT 'Error during data loading in the Bronze Layer';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '====================================================';
	END CATCH
END