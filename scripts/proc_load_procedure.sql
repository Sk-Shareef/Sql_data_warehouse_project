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
-- load procedure -- PROGRAMMABILIY -> SYSTEM STORE
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time=GETDATE();
        PRINT'============================================'
        PRINT'Loading Bronze Layer'
        PRINT'============================================'
        PRINT'--------------------------------------------'
        PRINT 'Loading CRM tables'
        PRINT'--------------------------------------------'

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_cust_info'
        TRUNCATE TABLE bronze.crm_cust_info;
    
        PRINT '>>Inserting Data into: bronze.crm_cust_info'
        -- BULK INSERT  -- IF we were execute this bulk insert, it doubles the rows example cust_info having 18493 it becomes 36986 rows  thats why we putting TRUNCATE ABOVE ON THIS 
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\share\OneDrive\Documents\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,           -- Skip the header row (column names) in the CSV. 
            FIELDTERMINATOR = ',',  -- The file uses commas to separate columns.
            ROWTERMINATOR = '\n',   -- The file uses a new line to start a new record.
            TABLOCK                 -- Locks the table to make the load much faster.
        );
        SET @end_time=GETDATE();
        PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'; 
        PRINT '>>-------------------';
        --select count(*)from bronze.crm_cust_info;

        SET @start_time=GETDATE();
        PRINT '>>Truncating Table: bronze.crm_pro_info'
        TRUNCATE TABLE bronze.crm_pro_info;

        PRINT '>>Inserting Data into: bronze.crm_pro_info'
        BULK INSERT bronze.crm_pro_info
        FROM 'C:\Users\share\OneDrive\Documents\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH(
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR='\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-------------------';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_sales_details'
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>>Inserting Data into: bronze.crm_sales_details'
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\share\OneDrive\Documents\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH(
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR='\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-------------------';

        PRINT'--------------------------------------------'
        PRINT 'Loading ERP tables'
        PRINT'--------------------------------------------'

        SET @start_time=GETDATE();
        PRINT '>>Truncating Table: bronze.erp_loc_a101'
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>>inserting Data into : bronze.erp_loc_a101'
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\share\OneDrive\Documents\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-------------------';

        SET @start_time=GETDATE();
        PRINT '>>Truncating Table: bronze.erp_cust_az12'
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>>Inserting Data into: bronze.erp_cust_az12'
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\share\OneDrive\Documents\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH(
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            ROWTERMINATOR='\n',
            TABLOCK
        );
        SET @end_time=GETDATE();
        PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-------------------';

        SET @start_time=GETDATE();
        PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2;'
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>>Inserting Data into: bronze.erp_px_cat_g1v2;'
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\share\OneDrive\Documents\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR='\n',
            TABLOCK
        );
        SET @end_time=GETDATE();
        PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>>-------------------';

        SET @batch_end_time=GETDATE();
        PRINT'Load Bronze Layer is Completed'
        PRINT ' Total Load DUration' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+ 'seconds';
    END TRY
    BEGIN CATCH
            PRINT '==========================================='
            PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
            PRINT 'ERROR MEASSAGE' + ERROR_MESSAGE();
            PRINT 'ERROR MEASSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
            PRINT 'ERROR MEASSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
            PRINT '==========================================='
        END CATCH
    END

