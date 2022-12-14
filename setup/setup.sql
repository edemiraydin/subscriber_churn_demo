// Create role, user, database
USE ROLE USERADMIN;
CREATE ROLE dbt_role;

USE ROLE SECURITYADMIN;
GRANT role dbt_role to role SYSADMIN;
GRANT role dbt_role to user <user>;

USE ROLE sysadmin;
CREATE DATABASE churn_demo;

USE ROLE SECURITYADMIN;

GRANT ALL ON DATABASE churn_demo TO ROLE dbt_role;


// Create warehouses 
USE SYSADMIN;
CREATE OR REPLACE WAREHOUSE DBT_WH WAREHOUSE_SIZE=SMALL;
CREATE OR REPLACE WAREHOUSE DBT_HIGH_MEM_WH WITH
  WAREHOUSE_SIZE = 'MEDIUM'
  WAREHOUSE_TYPE = 'SNOWPARK-OPTIMIZED'
  AUTO_SUSPEND = 100;
  
USE ROLE SECURITYADMIN;

GRANT ALL ON WAREHOUSE dbt_wh TO ROLE dbt_role;
GRANT USAGE ON WAREHOUSE dbt_high_mem_wh to ROLE DBT_ROLE;

  
 //Create event table for logging - Private Preview feature needs to be enabled as of Nov 2022
  
create event table CHURN_DEMO.CHURN_DEMO.DBT_DEMO_EVENTS;
alter account set event_table = CHURN_DEMO.CHURN_DEMO.DBT_DEMO_EVENTS;
alter schema CHURN_DEMO.CHURN_DEMO set log_level = info;
