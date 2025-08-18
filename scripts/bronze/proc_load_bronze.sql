/*
==============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==============================================================
Script Purpose:
    This stored procedured loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
	- Truncates the bronze tables before loading data.
	- Data is ingested via the PostgreSQL COPY command.

Parameters:
    None

Usage Example:
    CALL bronze.load_bronze();
==============================================================
*/

create or replace procedure bronze.load_bronze()
language plpgsql
as $$
declare
	start_time timestamp;
	end_time timestamp;
	duration bigint;
	batch_start_time timestamp;
	batch_end_time timestamp;
begin
	raise notice '==========================================================';
	raise notice 'Loading Bronze Layer';
	raise notice '==========================================================';

	raise notice '----------------------------------------------------------';
	raise notice 'Loading CRM Tables';
	raise notice '----------------------------------------------------------';

	batch_start_time = now();

	start_time := now(); 
	raise notice '>> Truncating Table: bronze.crm_cust_info';
	truncate table bronze.crm_cust_info;
	raise notice '>> Inserting Data Into: bronze.crm_cust_info';
	copy bronze.crm_cust_info 
	from '/Users/DatWguyn/Code/project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
	delimiter ','
	csv header;
	end_time := now();
	duration := extract(epoch from (end_time - start_time));
	raise notice '>> Load Duration: % seconds', duration;
	raise notice '---------------------------------------';
	
	start_time := now(); 
	raise notice '>> Truncating Table: bronze.crm_prd_info';
	truncate table bronze.crm_prd_info;
	raise notice '>> Inserting Data Into: bronze.crm_prd_info';
	copy bronze.crm_prd_info 
	from '/Users/DatWguyn/Code/project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
	delimiter ','
	csv header;
	end_time := now();
	duration := extract(epoch from (end_time - start_time));
	raise notice '>> Load Duration: % seconds', duration;
	raise notice '---------------------------------------';

	start_time := now();
	raise notice '>> Truncating Table: bronze.crm_sales_details';
	truncate table bronze.crm_sales_details;
	raise notice '>> Inserting Data Into: bronze.crm_sales_details';
	copy bronze.crm_sales_details
	from '/Users/DatWguyn/Code/project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
	delimiter ','
	csv header;
	end_time := now();
	duration := extract(epoch from (end_time - start_time));
	raise notice '>> Load Duration: % seconds', duration;

	raise notice '----------------------------------------------------------';
	raise notice 'Loading ERP Tables';
	raise notice '----------------------------------------------------------';

	start_time := now();
	raise notice '>> Truncating Table: bronze.erp_cust_az12';
	truncate table bronze.erp_cust_az12;
	raise notice '>> Inserting Data Into: bronze.erp_cust_az12';
	copy bronze.erp_cust_az12
	from '/Users/DatWguyn/Code/project/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
	delimiter ','
	csv header;
	end_time := now();
	duration := extract(epoch from (end_time - start_time));
	raise notice '>> Load Duration: % seconds', duration;
	raise notice '---------------------------------------';

	start_time := now();
	raise notice '>> Truncating Table: bronze.erp_loc_a101';
	truncate table bronze.erp_loc_a101;
	raise notice '>> Inserting Data Into: bronze.erp_loc_a101'; 
	copy bronze.erp_loc_a101
	from '/Users/DatWguyn/Code/project/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
	delimiter ','
	csv header;
	end_time := now();
	duration := extract(epoch from (end_time - start_time));
	raise notice '>> Load Duration: % seconds', duration;
	raise notice '---------------------------------------';

	start_time := now();
	raise notice '>> Truncating Table: bronze.erp_px_cat_g1v2';
	truncate table bronze.erp_px_cat_g1v2;
	raise notice '>> Inserting Data Into: bronze.erp_px_cat_g1v2'; 
	copy bronze.erp_px_cat_g1v2
	from '/Users/DatWguyn/Code/project/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
	delimiter ','
	csv header;
	end_time := now();
	duration := extract(epoch from (end_time - start_time));
	raise notice '>> Load Duration: % seconds', duration;

	batch_end_time := now();
	duration := extract(epoch from (batch_end_time - batch_start_time));
	raise notice '==========================================================';	
	raise notice 'Loading Bronze Layer is Completed!';
	raise notice '>> Total Load Duration: % seconds', duration;
	raise notice '==========================================================';
exception	
	when others then 
		raise notice '==========================================================';
		raise notice 'Error occured during loading Bronze Layer';
		raise notice '>> Error Message: %', sqlerrm;
		raise notice '>> Error Code: %', sqlstate;
		raise exception '-> Failed to load Bronze Layer';
		raise notice '==========================================================';
end;
$$;
