
# Data Cleaning & Validation Checklist

-- Rows count in each tables.
SELECT COUNT(*) FROM production_log;
SELECT COUNT(*) FROM machine_downtime;

-- Preview sample of each Table
SELECT * FROM production_log LIMIT 10;
SELECT * FROM machine_downtime LIMIT 10;


-- Checking for null values in key COLUMNS and Clean and handle Them.
SELECT SUM(operator_id IS NULL) FROM production_log;
SELECT SUM(operator_name IS NULL) FROM production_log;
SELECT * FROM production_log WHERE operator_name = '';
SELECT * FROM production_log WHERE operator_id = 'OP101';
SELECT * FROM production_log WHERE operator_id = 'OP102';
SELECT * FROM production_log WHERE operator_id = 'OP103';
SELECT * FROM production_log WHERE operator_id = 'OP108';
SELECT * FROM production_log WHERE operator_id = 'OP104';
SELECT * FROM production_log WHERE operator_id = 'OP107';
SELECT * FROM production_log WHERE operator_id = 'OP109';

SET SQL_SAFE_UPDATES = 0;
UPDATE production_log SET operator_name = 'Rahul Deshmukh' WHERE operator_id = 'OP101';
UPDATE production_log SET operator_name = 'Sneha Kulkarni' WHERE operator_id = 'OP102';
UPDATE production_log SET operator_name = 'Amit Sharma' WHERE operator_id = 'OP103';
UPDATE production_log SET operator_name = 'Kavita Joshi' WHERE operator_id = 'OP108';
UPDATE production_log SET operator_name = 'Priya Nair' WHERE operator_id = 'OP104';
UPDATE production_log SET operator_name = 'Sandeep Rao' WHERE operator_id = 'OP107';
UPDATE production_log SET operator_name = 'Manoj Verma' WHERE operator_id = 'OP109';
UPDATE production_log SET operator_name = 'Vikram Singh' WHERE operator_id = 'OP105';
UPDATE production_log SET operator_name = 'Anjali Patil' WHERE operator_id = 'OP106';				

SELECT SUM(machine_name IS NULL) FROM machine_downtime;
SELECT SUM(machine_type IS NULL) FROM machine_downtime;
SELECT SUM(downtime_reason IS NULL) FROM machine_downtime;
SELECT SUM(downtime_minutes IS NULL) FROM machine_downtime;

-- Check and handled severity missing values.

SELECT downtime_reason FROM (SELECT * FROM machine_downtime WHERE severity = '') as md GROUP BY downtime_reason;
UPDATE machine_downtime SET severity = 'NUll' WHERE severity = ''; 
SELECT * FROM machine_downtime WHERE severity = 'NUll';
UPDATE machine_downtime SET severity = 'Major' WHERE severity = 'NUll';

-- 
  SELECT * FROM machine_downtime WHERE reported_by = '';

-- Distinct values used to understand Categorical columns.
-- •Verify shift values only contain Morning / Afternoon / Night in both tables
SELECT DISTINCT shift FROM production_log;
SELECT DISTINCT line_id FROM production_log;

SELECT DISTINCT machine_type FROM machine_downtime;
SELECT DISTINCT shift FROM machine_downtime;
SELECT DISTINCT severity FROM machine_downtime;
SELECT DISTINCT resolved_status FROM machine_downtime;

-- Checking for duplicate on Primary Key Columns.
SELECT record_id ,COUNT(*) FROM production_log 
GROUP BY record_id
HAVING COUNT(*) > 1;

SELECT downtime_id ,COUNT(*) FROM machine_downtime
GROUP BY downtime_id
HAVING COUNT(*) > 1;

-- Date range between two tables.
SELECT 
     MAX(production_date) as latest_date,
     MIN(production_date) as earlist_date 
     FROM production_log;
     
SELECT 
     MAX(downtime_date) as latest_date,
     MIN(downtime_date) as earlist_date 
     FROM machine_downtime;

-- Verify machine_id values are consistent across both tables (10 distinct machines, M001–M010).
SELECT DISTINCT machine_id FROM machine_downtime;
SELECT DISTINCT machine_id FROM production_log;