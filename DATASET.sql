CREATE DATABASE IF NOT EXISTS Manufacturing_OEE_Project;
USE Manufacturing_OEE_Project;
SELECT DATABASE()
CREATE TABLE machine_master (
    machine_id VARCHAR(10) PRIMARY KEY,
    machine_name VARCHAR(50),
    machine_type VARCHAR(50),
    process VARCHAR(50),
    department VARCHAR(50)
);
INSERT INTO machine_master
(machine_id, machine_name, machine_type, process, department)
VALUES
('M-01', 'CNC-01', 'CNC Turning Machine', 'Turning', 'Production'),
('M-02', 'CNC-02', 'CNC Milling Machine', 'Milling', 'Production'),
('M-03', 'CNC-03', 'CNC Drilling Machine', 'Drilling', 'Production'),
('M-04', 'CNC-04', 'CNC Grinding Machine', 'Grinding', 'Production');
SELECT * FROM machine_master;
CREATE TABLE product_master (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    ideal_cycle_time DECIMAL(5,2)
);
INSERT INTO product_master
(product_id, product_name, category, ideal_cycle_time)
VALUES
('P-01', 'Shaft', 'Automotive', 1.00),
('P-02', 'Gear', 'Automotive', 1.20),
('P-03', 'Housing', 'Automotive', 1.50),
('P-04', 'Bracket', 'Automotive', 0.80);
SELECT * FROM product_master;
CREATE TABLE production_data (
    production_id INT PRIMARY KEY AUTO_INCREMENT,
    production_date DATE NOT NULL,
    shift VARCHAR(10) NOT NULL,
    machine_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    scheduled_time INT NOT NULL,
    planned_break INT NOT NULL,
    actual_qty INT NOT NULL,
    defect_qty INT NOT NULL,
    
    FOREIGN KEY (machine_id) 
        REFERENCES machine_master(machine_id),
        
    FOREIGN KEY (product_id) 
        REFERENCES product_master(product_id)
);
INSERT INTO production_data
(production_date, shift, machine_id, product_id,
 scheduled_time, planned_break, actual_qty, defect_qty)
VALUES
('2026-01-01', 'A', 'M-01', 'P-01', 480, 30, 420, 12),
('2026-01-01', 'B', 'M-01', 'P-01', 480, 30, 395, 18),
('2026-01-01', 'A', 'M-02', 'P-02', 480, 30, 350, 8),
('2026-01-01', 'B', 'M-02', 'P-02', 480, 30, 330, 15),
('2026-01-01', 'A', 'M-03', 'P-03', 480, 30, 290, 10),
('2026-01-01', 'B', 'M-03', 'P-03', 480, 30, 305, 7),
('2026-01-01', 'A', 'M-04', 'P-04', 480, 30, 540, 11),
('2026-01-01', 'B', 'M-04', 'P-04', 480, 30, 525, 9),
('2026-01-02', 'A', 'M-01', 'P-01', 480, 30, 430, 9),
('2026-01-02', 'B', 'M-02', 'P-02', 480, 30, 345, 12);
SELECT * FROM production_data;
CREATE TABLE downtime_data (
    downtime_id INT PRIMARY KEY AUTO_INCREMENT,
    production_id INT NOT NULL,
    downtime_reason VARCHAR(50) NOT NULL,
    downtime_category VARCHAR(50) NOT NULL,
    duration_min INT NOT NULL,

    FOREIGN KEY (production_id)
        REFERENCES production_data(production_id)
);
INSERT INTO downtime_data
(production_id, downtime_reason, downtime_category, duration_min)
VALUES
(1, 'Machine Breakdown', 'Equipment', 35),
(1, 'Material Shortage', 'Material', 15),
(1, 'Tool Failure', 'Equipment', 10),

(2, 'Machine Breakdown', 'Equipment', 45),
(2, 'Setup/Changeover', 'Process', 25),

(3, 'Material Shortage', 'Material', 20),
(3, 'Machine Breakdown', 'Equipment', 30),

(4, 'Machine Breakdown', 'Equipment', 40),
(4, 'Tool Failure', 'Equipment', 20),

(5, 'Setup/Changeover', 'Process', 30),
(5, 'Material Shortage', 'Material', 15),

(6, 'Machine Breakdown', 'Equipment', 25),
(6, 'Minor Stop', 'Process', 15),

(7, 'Machine Breakdown', 'Equipment', 20),
(7, 'Material Shortage', 'Material', 10),

(8, 'Tool Failure', 'Equipment', 25),
(8, 'Setup/Changeover', 'Process', 20),

(9, 'Machine Breakdown', 'Equipment', 30),
(9, 'Material Shortage', 'Material', 10),

(10, 'Machine Breakdown', 'Equipment', 35),
(10, 'Tool Failure', 'Equipment', 15);
SELECT * FROM downtime_data;
CREATE TABLE quality_data (
    quality_id INT PRIMARY KEY AUTO_INCREMENT,
    production_id INT NOT NULL,
    defect_type VARCHAR(50) NOT NULL,
    defect_qty INT NOT NULL,
    inspection_status VARCHAR(20) NOT NULL,

    FOREIGN KEY (production_id)
        REFERENCES production_data(production_id)
);
INSERT INTO quality_data
(production_id, defect_type, defect_qty, inspection_status)
VALUES
(1, 'Dimensional Error', 5, 'Rejected'),
(1, 'Surface Defect', 4, 'Rejected'),
(1, 'Tool Mark', 3, 'Rejected'),

(2, 'Dimensional Error', 8, 'Rejected'),
(2, 'Surface Defect', 6, 'Rejected'),
(2, 'Tool Mark', 4, 'Rejected'),

(3, 'Dimensional Error', 3, 'Rejected'),
(3, 'Surface Defect', 3, 'Rejected'),
(3, 'Tool Mark', 2, 'Rejected'),

(4, 'Dimensional Error', 6, 'Rejected'),
(4, 'Surface Defect', 5, 'Rejected'),
(4, 'Tool Mark', 4, 'Rejected'),

(5, 'Dimensional Error', 4, 'Rejected'),
(5, 'Surface Defect', 3, 'Rejected'),
(5, 'Tool Mark', 3, 'Rejected'),

(6, 'Dimensional Error', 3, 'Rejected'),
(6, 'Surface Defect', 2, 'Rejected'),
(6, 'Tool Mark', 2, 'Rejected'),

(7, 'Dimensional Error', 5, 'Rejected'),
(7, 'Surface Defect', 4, 'Rejected'),
(7, 'Tool Mark', 2, 'Rejected'),

(8, 'Dimensional Error', 4, 'Rejected'),
(8, 'Surface Defect', 3, 'Rejected'),
(8, 'Tool Mark', 2, 'Rejected'),

(9, 'Dimensional Error', 4, 'Rejected'),
(9, 'Surface Defect', 3, 'Rejected'),
(9, 'Tool Mark', 2, 'Rejected'),

(10, 'Dimensional Error', 5, 'Rejected'),
(10, 'Surface Defect', 4, 'Rejected'),
(10, 'Tool Mark', 3, 'Rejected');
SELECT * FROM quality_data;
SELECT 
    m.machine_id,
    m.machine_name,
    SUM(p.actual_qty) AS total_production
FROM machine_master m
JOIN production_data p
    ON m.machine_id = p.machine_id
GROUP BY m.machine_id, m.machine_name;

SELECT
    production_data.machine_id,
    SUM(production_data.defect_qty) AS total_defects,
    SUM(production_data.actual_qty) AS total_production
FROM production_data
GROUP BY production_data.machine_id;
SELECT * FROM downtime_data;
SELECT * FROM production_data;
SELECT
    production_data.machine_id,
    SUM(downtime_data.duration_min)
FROM production_data
JOIN downtime_data
    ON production_data.production_id = downtime_data.production_id
GROUP BY machine_id;
SELECT
    downtime_data.downtime_reason,
    SUM(downtime_data.duration_min) AS total_downtime
FROM production_data
JOIN downtime_data
    ON production_data.production_id = downtime_data.production_id
WHERE production_data.machine_id = 'M-01'
GROUP BY downtime_data.downtime_reason;
SELECT
    production_id,
    machine_id,
    shift,
    scheduled_time,
    planned_break,
    scheduled_time - planned_break AS planned_production_time
FROM production_data;
SELECT
    p.production_id,
    p.machine_id,
    p.scheduled_time - p.planned_break AS planned_production_time,
    SUM(d.duration_min) AS total_downtime,
    (p.scheduled_time - p.planned_break) - SUM(d.duration_min) AS operating_time
FROM production_data p
JOIN downtime_data d
    ON p.production_id = d.production_id
GROUP BY
    p.production_id,
    p.machine_id,
    p.scheduled_time,
    p.planned_break;
    SELECT
    p.machine_id,
    p.production_id,

    p.scheduled_time - p.planned_break
        AS planned_production_time,

    SUM(d.duration_min)
        AS total_downtime,

    (p.scheduled_time - p.planned_break)
        - SUM(d.duration_min)
        AS operating_time,

    (
        (
            (p.scheduled_time - p.planned_break)
            - SUM(d.duration_min)
        )
        /
        (p.scheduled_time - p.planned_break)
    ) * 100
        AS availability
FROM production_data p
JOIN downtime_data d
    ON p.production_id = d.production_id
GROUP BY
    p.production_id,
    p.machine_id,
    p.scheduled_time,
    p.planned_break;
    SELECT
    machine_id,
    production_id,
    actual_qty,
    defect_qty,
    actual_qty - defect_qty AS good_qty,
    ((actual_qty - defect_qty) / actual_qty) * 100 AS quality
FROM production_data;
SELECT
    p.production_id,
    p.machine_id,
    p.actual_qty,
    pm.ideal_cycle_time,

    p.scheduled_time - p.planned_break
        AS planned_production_time,

    SUM(d.duration_min)
        AS total_downtime,

    (p.scheduled_time - p.planned_break)
        - SUM(d.duration_min)
        AS operating_time,

    (
        p.actual_qty * pm.ideal_cycle_time
        /
        (
            (p.scheduled_time - p.planned_break)
            - SUM(d.duration_min)
        )
    ) * 100 AS performance

FROM production_data p

JOIN product_master pm
    ON p.product_id = pm.product_id

JOIN downtime_data d
    ON p.production_id = d.production_id

GROUP BY
    p.production_id,
    p.machine_id,
    p.actual_qty,
    pm.ideal_cycle_time,
    p.scheduled_time,
    p.planned_break;
    WITH production_summary AS (
    SELECT
        p.production_id,
        p.machine_id,
        p.product_id,
        p.actual_qty,
        p.defect_qty,
        p.scheduled_time,
        p.planned_break,

        -- Planned production time
        p.scheduled_time - p.planned_break AS planned_production_time,

        -- Total downtime for this production record
        COALESCE(SUM(d.duration_min), 0) AS total_downtime

    FROM production_data p

    LEFT JOIN downtime_data d
        ON p.production_id = d.production_id

    GROUP BY
        p.production_id,
        p.machine_id,
        p.product_id,
        p.actual_qty,
        p.defect_qty,
        p.scheduled_time,
        p.planned_break
),

oee_calculation AS (
    SELECT
        ps.*,
        pm.ideal_cycle_time,

        -- Operating Time
        ps.planned_production_time - ps.total_downtime
            AS operating_time,

        -- Good Production
        ps.actual_qty - ps.defect_qty
            AS good_qty

    FROM production_summary ps

    JOIN product_master pm
        ON ps.product_id = pm.product_id
)

SELECT
    machine_id,

    -- Availability
    ROUND(
        SUM(operating_time)
        / SUM(planned_production_time) * 100,
        2
    ) AS availability,

    -- Performance
    ROUND(
        SUM(actual_qty * ideal_cycle_time)
        / SUM(operating_time) * 100,
        2
    ) AS performance,

    -- Quality
    ROUND(
        SUM(good_qty)
        / SUM(actual_qty) * 100,
        2
    ) AS quality,

    -- OEE
    ROUND(
        (
            SUM(operating_time)
            / SUM(planned_production_time)
        )
        *
        (
            SUM(actual_qty * ideal_cycle_time)
            / SUM(operating_time)
        )
        *
        (
            SUM(good_qty)
            / SUM(actual_qty)
        )
        * 100,
        2
    ) AS OEE

FROM oee_calculation

GROUP BY machine_id
ORDER BY OEE ASC;
SELECT
    d.downtime_reason,
    SUM(d.duration_min) AS total_downtime
FROM production_data p
JOIN downtime_data d
    ON p.production_id = d.production_id
WHERE p.machine_id = 'M-02'
GROUP BY d.downtime_reason
ORDER BY total_downtime DESC;
SELECT
    q.defect_type,
    SUM(q.defect_qty) AS total_defects
FROM production_data p
JOIN quality_data q
    ON p.production_id = q.production_id
WHERE p.machine_id = 'M-02'
GROUP BY q.defect_type
ORDER BY total_defects DESC;
SELECT
    p.shift,
    SUM(p.actual_qty) AS total_production,
    SUM(p.defect_qty) AS total_defects,
    SUM(d.duration_min) AS total_downtime,
    ROUND(
        SUM(p.defect_qty) / SUM(p.actual_qty) * 100,
        2
    ) AS defect_rate
FROM production_data p
JOIN downtime_data d
    ON p.production_id = d.production_id
WHERE p.machine_id = 'M-02'
GROUP BY p.shift
ORDER BY defect_rate DESC;
SELECT
    p.machine_id,
    SUM(p.actual_qty) AS total_production,
    SUM(p.defect_qty) AS total_defects,
    SUM(d.duration_min) AS total_downtime,

    ROUND(
        SUM(p.defect_qty) / SUM(p.actual_qty) * 100,
        2
    ) AS defect_rate,

    ROUND(
        SUM(d.duration_min) /
        SUM(p.scheduled_time - p.planned_break) * 100,
        2
    ) AS downtime_rate

FROM production_data p

JOIN downtime_data d
    ON p.production_id = d.production_id

GROUP BY p.machine_id
ORDER BY downtime_rate DESC;
SELECT
    d.downtime_reason,
    SUM(d.duration_min) AS total_downtime
FROM downtime_data d
GROUP BY d.downtime_reason
ORDER BY total_downtime DESC;
SELECT
    downtime_reason,
    total_downtime,

    ROUND(
        total_downtime /
        SUM(total_downtime) OVER () * 100,
        2
    ) AS contribution_pct,

    ROUND(
        SUM(total_downtime) OVER (
            ORDER BY total_downtime DESC
        )
        /
        SUM(total_downtime) OVER () * 100,
        2
    ) AS cumulative_pct

FROM (
    SELECT
        downtime_reason,
        SUM(duration_min) AS total_downtime
    FROM downtime_data
    GROUP BY downtime_reason
) AS downtime_summary

ORDER BY total_downtime DESC;
   CREATE VIEW vw_oee_analysis AS

WITH production_summary AS (
    SELECT
        p.production_id,
        p.production_date,
        p.shift,
        p.machine_id,
        p.product_id,
        p.actual_qty,
        p.defect_qty,
        p.scheduled_time,
        p.planned_break,

        p.scheduled_time - p.planned_break
            AS planned_production_time,

        COALESCE(SUM(d.duration_min), 0)
            AS total_downtime

    FROM production_data p

    LEFT JOIN downtime_data d
        ON p.production_id = d.production_id

    GROUP BY
        p.production_id,
        p.production_date,
        p.shift,
        p.machine_id,
        p.product_id,
        p.actual_qty,
        p.defect_qty,
        p.scheduled_time,
        p.planned_break
)

SELECT
    ps.production_id,
    ps.production_date,
    ps.shift,
    ps.machine_id,
    ps.product_id,
    pm.product_name,
    ps.actual_qty,
    ps.defect_qty,

    ps.actual_qty - ps.defect_qty
        AS good_qty,

    pm.ideal_cycle_time,

    ps.planned_production_time,

    ps.total_downtime,

    ps.planned_production_time - ps.total_downtime
        AS operating_time,

    ROUND(
        (
            (ps.planned_production_time - ps.total_downtime)
            / ps.planned_production_time
        ) * 100,
        2
    ) AS availability,

    ROUND(
        (
            ps.actual_qty * pm.ideal_cycle_time
            /
            (ps.planned_production_time - ps.total_downtime)
        ) * 100,
        2
    ) AS performance,

    ROUND(
        (
            (ps.actual_qty - ps.defect_qty)
            / ps.actual_qty
        ) * 100,
        2
    ) AS quality,

    ROUND(
        (
            (ps.planned_production_time - ps.total_downtime)
            / ps.planned_production_time
        )
        *
        (
            ps.actual_qty * pm.ideal_cycle_time
            /
            (ps.planned_production_time - ps.total_downtime)
        )
        *
        (
            (ps.actual_qty - ps.defect_qty)
            / ps.actual_qty
        )
        * 100,
        2
    ) AS OEE

FROM production_summary ps

JOIN product_master pm
    ON ps.product_id = pm.product_id;
    SELECT *
FROM vw_oee_analysis;
CREATE VIEW vw_downtime_analysis AS

SELECT
    d.downtime_id,
    p.production_id,
    p.production_date,
    p.shift,
    p.machine_id,
    p.product_id,
    d.downtime_reason,
    d.downtime_category,
    d.duration_min

FROM production_data p

JOIN downtime_data d
    ON p.production_id = d.production_id;
    SELECT *
FROM vw_downtime_analysis;
CREATE VIEW vw_quality_analysis AS

SELECT
    q.quality_id,
    p.production_id,
    p.production_date,
    p.shift,
    p.machine_id,
    p.product_id,
    q.defect_type,
    q.defect_qty,
    q.inspection_status

FROM production_data p

JOIN quality_data q
    ON p.production_id = q.production_id;
    SELECT * FROM vw_quality_analysis
    SELECT SUM(actual_qty) AS total_production
FROM production_data;
SELECT SUM(defect_qty) AS total_defects
FROM production_data;
SELECT SUM(duration_min) AS total_downtime
FROM downtime_data;
SELECT
    p.machine_id,
    SUM(p.actual_qty) AS total_production,
    SUM(p.defect_qty) AS total_defects,
    SUM(d.duration_min) AS total_downtime
FROM production_data p
JOIN downtime_data d
    ON p.production_id = d.production_id
GROUP BY p.machine_id
ORDER BY p.machine_id;