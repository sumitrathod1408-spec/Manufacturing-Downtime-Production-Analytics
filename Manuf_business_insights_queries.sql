
-- Q1.	List all production records for machine M001, sorted by production_date
SELECT * FROM production_log
 WHERE machine_id = 'M001'
 ORDER BY production_date;
 
 -- Q2.	Find all downtime events with severity = 'Critical'.
 SELECT * FROM machine_downtime 
 WHERE severity = 'Critical';
 
 -- Q3.	List distinct product_code values manufactured on Line B.
 SELECT DISTINCT product_code 
 FROM production_log
 WHERE line_id = 'Line B';
 
 -- Q4.	Find all production records where rejected_units is NULL.
 SELECT * FROM production_log
 WHERE rejected_units IS NULL;
 
 -- Q5.	INNER JOIN production_log and machine_downtime on (machine_id, production_date/downtime_date, shift)
      --  to list every shift that had at least one downtime event
	SELECT PL.machine_id, PL.production_date, MD.downtime_date, MD.shift FROM production_log PL
	INNER JOIN machine_downtime MD
	ON PL.machine_id = MD.machine_id
    AND PL.production_date = MD.downtime_date
    AND PL.shift = MD.shift;
    
-- Q6.	LEFT JOIN production_log to machine_downtime to list every production shift along with total downtime minutes for that shift (use 0 where there was no downtime).
SELECT p.machine_id, p.production_date, p.shift, COALESCE(SUM(m.downtime_minutes), 0) FROM production_log p
 LEFT JOIN machine_downtime m 
 ON p.machine_id = m.machine_id
 AND p.production_date = m.downtime_date
 AND p.shift = m.shift
 GROUP BY p.machine_id,
 p.production_date,
 P.shift;
 
-- Q7.	Find machines that appear in production_log but have zero downtime events in the entire dataset (LEFT JOIN + IS NULL).
SELECT p.machine_id, m.machine_name FROM production_log P
 LEFT JOIN machine_downtime m 
 ON p.machine_id = m.machine_id
 WHERE m.machine_id IS NULL;

-- the two tables to find the single longest downtime event and the production output for that same shift.
SELECT p.machine_id,
       p.production_date,
       p.shift,
       m.downtime_minutes,
       p.produced_units
 FROM production_log p 
JOIN machine_downtime m 
ON p.machine_id = m.machine_id
AND p.production_date = m.downtime_date
AND p.shift = m.shift 
ORDER BY downtime_minutes DESC
LIMIT 1;

-- Q9.	Total produced_units and rejected_units per machine_id.
SELECT machine_id, SUM(produced_units) Total_PU,
                   SUM(rejected_units) Total_RU
                   FROM production_log group by machine_id;  
	-- M008 produced most(72933) units
    -- M010 produced least(17229) units
    
-- Q10.	Total downtime_minutes per downtime_reason, ordered from highest to lowest.
SELECT downtime_reason, 
       SUM(downtime_minutes) Total_DT
       FROM machine_downtime
       GROUP BY downtime_reason
       ORDER BY Total_DT
       DESC;
       
-- Q11.	Average run_hours per shift across all machines
SELECT shift, AVG(run_hours) FROM production_log 
GROUP BY shift;

-- Q12.	Count of downtime events per severity level per plant/line


-- Q13.	Which line (Line A/B/C) has the highest total rejected_units
SELECT line_id, 
       SUM(rejected_units) Total_RU
       FROM production_log
       GROUP BY line_id
       ORDER BY Total_RU DESC;
       -- line C has the highest total rejected_units(4214)
       
-- 

 
 