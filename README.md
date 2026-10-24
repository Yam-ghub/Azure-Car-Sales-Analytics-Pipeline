# Azure-Car-Sales-Analytics-Pipeline

## Overview
This project processes car sales data end to end using Azure cloud technologies. The data is ingested from GitHub into SQL Server with Azure Data Factory, then loaded incrementally into Azure Data Lake Storage (ADLS) as Parquet files. Azure Databricks refines it through a medallion architecture (Bronze, Silver, Gold), producing a star-schema model that is ready for analytics.

## How I Built It
1. I ingested the car sales data from GitHub into a SQL Server database using an Azure Data Factory Copy Activity.
2. I created a watermark table in SQL Server to store the last load value, so each run knows where the previous one stopped.
3. I added a Lookup Activity to read the last load value and the maximum load value from the source.
4. I implemented incremental loading with upsert logic, so only new or updated records are processed and old records are never reloaded. This reduces both cost and run time.
5. I used a second Copy Activity to move the incremental data from SQL Server into the Bronze layer in ADLS as Parquet files.
6. I created the UpdateWatermarkTable stored procedure, which updates the last load value after each successful run.
7. I used Azure Databricks to read the Bronze Parquet files, then transformed, cleaned, and deduplicated the data into the Silver layer.
8. I built the Gold layer as a star schema with four dimension tables (gold_dim_model, gold_dim_branch, gold_dim_dealer, gold_dim_date) and one fact table (fact_sales), making the data analytics-ready.




