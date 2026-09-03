# Manufacturing Operations & OEE Improvement Analysis

## Overview

This project analyzes manufacturing production, downtime, quality, and machine performance data to identify operational losses and prioritize improvement opportunities.

The analysis combines **SQL-based data analysis in MySQL** with an interactive **Power BI dashboard** to evaluate Overall Equipment Effectiveness (OEE), machine performance, downtime causes, quality losses, and shift-level performance.

The project is designed from an **Industrial Engineering / Manufacturing Operations** perspective, with data analytics used to support operational decision-making.

---

## Business Problem

A manufacturing plant was experiencing variations in machine performance and production losses.

The objective of the analysis was to:

- Evaluate machine performance using OEE.
- Identify underperforming machines.
- Analyze downtime and its major causes.
- Identify major quality loss categories.
- Compare performance across shifts.
- Prioritize areas for operational improvement.

---

## Objectives

1. Calculate and analyze OEE for each machine.
2. Compare Availability, Performance, and Quality.
3. Identify machines with higher downtime and downtime rates.
4. Analyze downtime causes using cause-level aggregation and Pareto analysis.
5. Analyze defect types and quality losses.
6. Compare production and defect rates across shifts.
7. Identify the priority machine and major improvement areas.
8. Build an interactive Power BI dashboard for management-level analysis.

---

## Dataset

The project uses a simulated manufacturing dataset containing production, downtime, and quality records.

### Key data points

- **Total Production:** 3,930 units
- **Total Defects:** 111 units
- **Total Downtime:** 490 minutes
- **Machines:** 4
- **Shifts:** A and B
- **Products:** 4

### Machines

- M-01 – CNC Turning Machine
- M-02 – CNC Milling Machine
- M-03 – CNC Drilling Machine
- M-04 – CNC Grinding Machine

---

## Data Model

The project uses separate master and transactional/analysis tables.

### Master Data

- `machine_master`
- `product_master`

### Production Data

- `production_data`

### Downtime Data

- `downtime_data`

### Quality Data

- `quality_data`

Power BI uses analysis views created from the SQL database and a separate `Machine` dimension table to enable machine-level filtering across the dashboard.

---

## OEE Methodology

Overall Equipment Effectiveness (OEE) was calculated using three components:

### Availability

```text
Availability = Operating Time / Planned Production Time × 100

Performance = Actual Production × Ideal Cycle Time / Operating Time × 100
Quality = Good Units / Total Production × 100
OEE = Availability × Performance × Quality