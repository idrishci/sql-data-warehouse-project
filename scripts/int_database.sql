/*
===============================
Create Database And Schemas
===============================
Script purpose :
  The scripte create a new database after checking if it exist
  if it existe drop it and create a new one after create the three schemas : "bronze" "silver" "gold"

WARNING :
  Runing this script it will drop the entire 'Datawarehouse' if it exists.

*/

USE MASTER;
GO
  --Check If Database Existe Before If Existe DROP it And Create A New One 
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name ='Datawarehouse')
BEGIN 
	CREATE DATABASE Datawarehouse;
END
ELSE
BEGIN 
	DROP DATABASE Datawarehouse;
	CREATE DATABASE Datawarehouse;
END
GO
USE Datawarehouse;
GO
  -- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
