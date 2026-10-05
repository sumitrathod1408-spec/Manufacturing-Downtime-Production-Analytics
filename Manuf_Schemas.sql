CREATE DATABASE mfg_downtime_analytics;
USE mfg_downtime_analytics;

#CREATED THE PRODUCTION_LOG TABLE.

CREATE TABLE production_log(
   record_id VARCHAR(20) PRIMARY KEY,
   production_date DATE NOT NULL,
   shift  VARCHAR(20) NOT NULL,
   machine_id VARCHAR(20) NOT NULL,
   line_id VARCHAR(20) ,
   product_code VARCHAR(20),
   planned_units INT ,
   produced_units INT ,
   rejected_units INT NULL,
   run_hours  DECIMAL(4,1) ,
   operator_id VARCHAR(20) ,
   operator_name VARCHAR(50) ,
   INDEX idx_machine_date_shift (machine_id, production_date, shift)
   );
   
  #CREATED MACHINE_DOWNTIME TABLE. 
   
CREATE TABLE machine_downtime(
  downtime_id VARCHAR(25) PRIMARY KEY ,
  machine_id  VARCHAR(25) NOT NULL ,
  machine_name VARCHAR(50) ,
  machine_type VARCHAR(50) ,
  downtime_date DATE  NOT NULL ,
  shift   VARCHAR(25) NOT NULL,
  downtime_reason  VARCHAR(50) ,
  downtime_minutes INT ,
  severity  VARCHAR(25) NOT NULL ,
  reported_by  VARCHAR(25)  NOT NULL ,
  resolved_status VARCHAR(25) NOT NULL , 
  INDEX idx_machine_date_shift (machine_id, downtime_date, shift)
  );
  
  #CHECK AFTER IMPORT DATA
  
   SELECT * FROM production_log;
   SELECT * FROM machine_downtime ;
   
   SELECT downtime_reason, severity FROM machine_downtime GROUP BY downtime_reason,severity;
    