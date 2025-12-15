/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @START_TIME DATETIME, @END_TIME DATETIME, @BATCH_START_TIME DATETIME, @BATCH_END_TIME DATETIME;
	BEGIN TRY

		SET @BATCH_START_TIME= GETDATE();

		PRINT'=================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '==========';

		PRINT '---------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '-------------';

		SET @START_TIME=GETDATE();
		PRINT '>>>TRUNCATING TABLE BRONZE.CRM_CUST_INFO' ;
		TRUNCATE  TABLE  BRONZE.CRM_CUST_INFO;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';

		BULK INSERT BRONZE.CRM_CUST_INFO
		FROM 'C:\Users\HP\OneDrive\Desktop\DA Project 1\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\CUST_INFO.CSV'
		WITH(
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
	
		SET @END_TIME=GETDATE();
		PRINT '>>LOAD DURATION:' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + ' SECONDS'
		PRINT '>>>---------------------';

		SET @START_TIME = GETDATE();
		PRINT '>>>TRUNCATING TABLE BRONZE.CRM_PRD_INFO' ;
		TRUNCATE TABLE BRONZE.CRM_PRD_INFO;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT BRONZE.CRM_PRD_INFO
		FROM 'C:\Users\HP\OneDrive\Desktop\DA Project 1\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\PRD_INFO.CSV'
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @END_TIME=GETDATE();
		PRINT '>>LOAD DURATION:' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + ' SECONDS'
		PRINT '>>>---------------------'

		SET @START_TIME= GETDATE();
		PRINT '>>>TRUNCATING TABLE BRONZE.CRM_SALES_DETAILS' ;
		TRUNCATE TABLE BRONZE.CRM_SALES_DETAILS;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT BRONZE.CRM_SALES_DETAILS
		FROM 'C:\Users\HP\OneDrive\Desktop\DA Project 1\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\SALES_DETAILS.CSV'
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @END_TIME=GETDATE();
		PRINT '>>LOAD DURATION:' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + ' SECONDS';
		PRINT '>>>---------------------'

		PRINT '---------------';
		PRINT 'ERP TABLES'
		PRINT '-------------'

		SET @START_TIME  = GETDATE();
		PRINT '>>>TRUNCATING TABLE BRONZE.ERP_LOC_A101' ;
		TRUNCATE TABLE BRONZE.ERP_LOC_A101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT BRONZE.ERP_LOC_A101
		FROM 'C:\Users\HP\OneDrive\Desktop\DA Project 1\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.CSV'
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @END_TIME=GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + ' SECONDS';
		PRINT '>>---------'

		SET @START_TIME=GETDATE();
		PRINT '>>>TRUNCATING TABLE BRONZE.ERP_CUST_AZ12'
		TRUNCATE TABLE BRONZE.ERP_CUST_AZ12

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT BRONZE.ERP_CUST_AZ12
		FROM 'C:\Users\HP\OneDrive\Desktop\DA Project 1\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.CSV'
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @END_TIME=GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + ' SECONDS';
		PRINT '>>---------'

		SET @START_TIME=GETDATE();
		PRINT '>>>TRUNCATING TABLE BRONZE.ERP_PX_CAT_G1V2'
		TRUNCATE TABLE BRONZE.ERP_PX_CAT_G1V2

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT BRONZE.ERP_PX_CAT_G1V2
		FROM 'C:\Users\HP\OneDrive\Desktop\DA Project 1\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.CSV'
		WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @END_TIME=GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + ' SECONDS';
		PRINT '>>--------'
		 
		SET @BATCH_END_TIME= GETDATE();
		PRINT '================='
		PRINT 'LOADING BRONZE LAYER IS COMPLETED'
		PRINT '  - TOTAL LOAD DURATION: ' + CAST (DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME) AS NVARCHAR) + 'SECONDS' ;
		PRINT '-----------------------------------------------------------------------'
	
	END TRY
	BEGIN CATCH
	PRINT '============'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '============'
	END CATCH
END
