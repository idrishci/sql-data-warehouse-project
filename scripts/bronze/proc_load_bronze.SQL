/*
=========================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
=========================================
Script Purpose :
  This is the load procedure load data into the bronze schema from external csv file
  It performs the following actions:
    - Truncate the tables before loading data
    - Use the 'BULK INSERT' command to load data from the csv files into the bronze tables
    
Parametre :
  the procedure doesn't have any parametres or any return value
  
Usage Example :
  EXEC bronze.load_bronze;
  
*/

DROP PROCEDURE bronze.load_bronze;
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
	DECLARE @Start_time DATETIME ,@End_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME;
	BEGIN TRY
		
		PRINT '============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '============================================';

		PRINT '--------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------';
		SET @batch_start_time=GETDATE();
		SET @Start_time=GETDATE();
		PRINT '>> Truncating table';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into table';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\user\Downloads\programmation\datawarehouse_project\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time= GETDATE();
		PRINT '>> Load Duration '+ CAST(DATEDIFF(second,@Start_time,@End_time) AS NVARCHAR) + ' Seconds'
		SELECT COUNT(*) FROM crm_cust_info

		SET @Start_time=GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\user\Downloads\programmation\datawarehouse_project\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time= GETDATE();
		PRINT '>> Load Duration '+ CAST(DATEDIFF(second,@Start_time,@End_time) AS NVARCHAR) + ' Seconds'
		SELECT COUNT(*) FROM bronze.crm_prd_info

		SET @Start_time=GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\user\Downloads\programmation\datawarehouse_project\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time= GETDATE();
		PRINT '>> Load Duration '+ CAST(DATEDIFF(second,@Start_time,@End_time) AS NVARCHAR) + ' Seconds'
		SELECT COUNT(*) FROM bronze.crm_sales_details

		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\user\Downloads\programmation\datawarehouse_project\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SELECT COUNT(*) FROM bronze.erp_cust_az12

		PRINT '--------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------';

		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\user\Downloads\programmation\datawarehouse_project\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SELECT COUNT(*) FROM bronze.erp_loc_a101

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\user\Downloads\programmation\datawarehouse_project\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2
		SET @batch_end_time = GETDATE()
		print'================================='
		PRINT '>>Total load duration is : ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time)AS NVARCHAR) + ' seconds'
		print '================================'
	END TRY
	BEGIN CATCH
		PRINT '==========================';
		PRINT 'ERROR IN THE LOADING BRONZE LAYER';
		PRINT '==========================';
		PRINT 'Error Message'+ ERROR_MESSAGE();
		Print 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		Print 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================';
	END CATCH
END

