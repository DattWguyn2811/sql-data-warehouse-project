/*
======================================================
Create database and schema
======================================================
Script purpose: 
  This script creates a new database named 'datawarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database: 'bronze', 'silver' and 'gold' within the database: 'bronze', 'silver', 'gold'.

WARNING: 
  Running this script will drop the entire 'datawarehouse' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script. 
*/

-- Drop an recreate database
drop database if exists datawarehouse;

-- Create database 'datawarehouse'
create database datawarehouse;

-- Connect to 'datawarehouse' database 
\c datawarehouse;

-- Create schemas
create schema bronze;
create schema silver;
create schema gold;
