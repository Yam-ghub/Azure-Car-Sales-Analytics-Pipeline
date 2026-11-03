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
1. Source ingestion: I ingested the car sales dataset from GitHub into a SQL Server database using an Azure Data Factory Copy Activity.
2. Watermark table: I created a watermark table in SQL Server to store the last successfully processed load value, allowing each pipeline run to determine where the previous load stopped.
3. Incremental boundaries: I used Lookup Activities in Azure Data Factory to retrieve the previous watermark value and determine the maximum available load value from the source.
4. Incremental loading: I configured the pipeline to process only records within the current watermark range, preventing the entire dataset from being reprocessed during every run. This reduces unnecessary data movement, processing time, and compute usage.
5. Bronze ingestion: I used a second Copy Activity to move the incremental dataset from SQL Server into the Bronze layer of Azure Data Lake Storage as Parquet files.
6. Watermark update: I created the UpdateWatermarkTable stored procedure to update the stored watermark after the successful completion of the incremental load.
7. Silver transformation: I used Azure Databricks to read the Bronze Parquet files and perform data cleaning, transformation, and deduplication before writing the refined data into the Silver layer.
8. Gold dimensional model: I transformed the Silver data into a Gold-layer star schema consisting of four dimension tables and one fact table, making the dataset ready for analytics and business intelligence workloads.

## Pipeline Architecture
<img src="https://github.com/Yam-ghub/Azure-Car-Sales-Analytics-Pipeline/blob/main/img/Pipeline_Architecture.png" width="1200">

| Medallion term | Equivalent term | Purpose |
|---|---|---|
| Bronze | Landing / Raw | Stores incrementally loaded source data in Parquet format while preserving data close to its ingested state |
| Silver | Cleansed / Curated | Cleans, transforms, and deduplicates Bronze data to create a reliable dataset |
| Gold | Presentation / Analytics | Converts curated Silver data into an analytics-ready dimensional model |

