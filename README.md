# Data Warehouse and Analytics Project 

Welcome to the **Data Warehouse and Analytics Project** repository!

This project demonstrates a comprehensive data warehousing and analytics solution using the **Medallion Architecture**. It covers the end-to-end process from raw data ingestion to generating actionable business insights using SQL Server.

----

## Project Requirements

### 1. Data Engineering (Building the Data Warehouse)

**Objective:**
Develop a modern data warehouse using SQL Server to consolidate retail data, enabling analytical reporting and informed decision-making.

**Specifications:**
- **Data Sources:** Utilizes the **Sample - Superstore** dataset, architected to simulate two distinct source systems (ERP and CRM) to demonstrate data integration techniques.
- **Architecture:** Implements a **Medallion Architecture**:
  - **Bronze (Raw):** Landing the data exactly as it appears in the source.
  - **Silver (Cleansed):** Standardizing data types, fixing date formats, and handling nulls.
  - **Gold (Analytics):** Business-ready tables designed for reporting.
- **Data Quality:** Systematic cleansing of customer segments, product categories, and transaction inconsistencies.
- **Integration:** Merging disparate datasets into a single, unified star schema.
- **Automation:** Using **Stored Procedures** to manage the ETL pipeline with built-in error handling (`TRY...CATCH`).

### 2. Data Analytics (BI: Analytics & Reporting)

**Objective:**
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior:** Identifying high-value segments and customer loyalty.
- **Product Performance:** Analyzing category-level profitability and sub-category trends.
- **Sales Trends:** Tracking revenue growth and shipping efficiency across different regions.

----

## Technical Stack
- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Stored Procedures, Views, DDL/DML)
- **Architecture:** Medallion (Bronze -> Silver -> Gold)
- **Dataset:** Sample - Superstore Retail Data

## License
This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

## About Me
Hi there! I'm **SHAREEF SHAIK**. I'm a student passionate about data engineering and analytics. I enjoy building data-driven solutions and exploring how raw information can be transformed into strategic business value.
