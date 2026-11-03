# Azure-Car-Sales-Analytics-Pipeline
## Overview
This project demonstrates a complete Azure-based data engineering workflow, from source ingestion and incremental processing to transformation and dimensional modeling.

The solution uses Azure Data Factory (ADF) to orchestrate data movement between GitHub, SQL Server, and Azure Data Lake Storage. A watermark-based incremental loading strategy ensures that subsequent pipeline runs process only records that are new or have changed since the previous successful load.

Azure Databricks then processes the Bronze data through Silver and Gold layers, where the data is cleaned, deduplicated, transformed, and modeled into a star schema suitable for downstream analytics and reporting.

## What this project demonstrates:
- Cloud-based data pipeline orchestration using Azure Data Factory
- Data ingestion from GitHub into SQL Server
- Incremental data loading using a watermark-based pattern
- Pipeline control using ADF Lookup Activities and Stored Procedures
- Cloud data storage using Azure Data Lake Storage (ADLS)
- Efficient analytical storage using Parquet
- Medallion architecture using Bronze, Silver, and Gold layers
- Data transformation and deduplication using Azure Databricks
- Dimensional modeling using a star schema
- Separation of ingestion, transformation, and analytics layers

## How I Built It
1. I ingested the car sales data from GitHub into a SQL Server database using an Azure Data Factory Copy Activity.
2. I created a watermark table in SQL Server to store the last load value, so each run knows where the previous one stopped.
3. I added a Lookup Activity to read the last load value and the maximum load value from the source.
4. I implemented incremental loading with upsert logic, so only new or updated records are processed and old records are never reloaded. This reduces both cost and run time.
5. I used a second Copy Activity to move the incremental data from SQL Server into the Bronze layer in ADLS as Parquet files.
6. I created the UpdateWatermarkTable stored procedure, which updates the last load value after each successful run.
7. I used Azure Databricks to read the Bronze Parquet files, then transformed, cleaned, and deduplicated the data into the Silver layer.
8. I built the Gold layer as a star schema with four dimension tables (gold_dim_model, gold_dim_branch, gold_dim_dealer, gold_dim_date) and one fact table (fact_sales), making the data analytics-ready.


## Pipeline Architecture
<img src="https://github.com/Yam-ghub/Azure-Car-Sales-Analytics-Pipeline/blob/main/img/Pipeline_Architecture.png" width="1200">

Medallion LayerEquivalent TermPurposeBronzeLanding / RawStores incrementally loaded source data in Parquet format while preserving data close to its ingested stateSilverCleansed / CuratedCleans, transforms, and deduplicates Bronze data to create a reliable datasetGoldPresentation / AnalyticsConverts curated Silver data into an analytics-ready dimensional model
