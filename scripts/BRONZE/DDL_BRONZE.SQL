/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE BRONZE.CRM_CUST_INFO
(
CST_ID INT,
CST_KEY NVARCHAR(50),
CST_FIRSTNAME NVARCHAR(50),
CST_LASTNAME NVARCHAR(50),
CST_MATERIAL_STATUS NVARCHAR(50),
CST_GNDR NVARCHAR(50),
CST_CREATE_DATE DATE
)

CREATE TABLE BRONZE.CRM_PRD_INFO
(
PRD_ID INT,
PRD_KEY NVARCHAR(50),
PRD_NM NVARCHAR(50),
PRD_COST INT,
PRD_LINE NVARCHAR(50),
PRD_START_DT DATETIME,
PRD_END_DT DATETIME
)

CREATE TABLE BRONZE.CRM_SALES_DETAILS
(
SLS_ORD_NUM NVARCHAR(50),
SLS_PRD_KEY NVARCHAR(50),
SLS_CUST_ID INT,
SLS_ORDER_DT INT,
SLS_SHIP_DT INT,
SLS_DUE_DT INT,
SLS_SALES INT,
SLS_QUANTITY INT,
SLS_PRICE INT
)

CREATE TABLE BRONZE.ERP_LOC_A101
(
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
)

CREATE TABLE BRONZE.ERP_CUST_AZ12
(
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50)
)

CREATE TABLE BRONZE.ERP_PX_CAT_G1V2
(
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
)
