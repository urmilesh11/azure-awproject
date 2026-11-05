# Azure End-to-End Data Engineering Project (AdventureWorks)

An end-to-end data pipeline on Azure using the medallion architecture (Bronze, Silver, Gold), built on the AdventureWorks sample dataset.

## Architecture

```
Source data -> Azure Data Factory -> ADLS Gen2 (Bronze)
            -> Azure Databricks (PySpark) -> ADLS Gen2 (Silver)
            -> Azure Synapse Analytics (serverless SQL views) -> Gold
            -> Power BI
```

## Tech stack

- **Azure Data Factory**: ingestion pipeline
- **Azure Data Lake Storage Gen2**: bronze, silver and gold containers
- **Azure Databricks (PySpark)**: data transformation
- **Azure Synapse Analytics**: serverless SQL views over the silver data
- **Power BI**: reporting and dashboards
- **Microsoft Entra ID app registration**: secure Databricks-to-storage access (OAuth)

## Layers

### Bronze: raw ingestion
- An ADF pipeline copies the raw AdventureWorks files from [source, e.g. GitHub/HTTP] into the bronze container.
- Pipeline definition: [`adf/`](adf/)

### Silver: cleaned and transformed
- A Databricks notebook reads the bronze data and applies transformations with PySpark, such as [e.g. creating a Fullname column with concat_ws, date conversions, column cleanup].
- Output is written as Parquet to the silver container.
- Notebook: [`silver_layer.ipynb`](silver_layer.ipynb)

### Gold: business-ready views
- Synapse serverless SQL creates a `gold` schema and views over the silver Parquet files using `OPENROWSET`.
- Scripts: [`synapse/`](synapse/)

### Reporting
- Power BI connects to the Synapse gold views to build [e.g. sales and customer dashboards].

## Repository structure

```
adf/        Data Factory pipeline JSON (bronze ingestion)
synapse/    SQL scripts for the gold schema and views
silver_layer.ipynb   Databricks transformation notebook
```

## How to reproduce

1. Create a resource group, ADLS Gen2 storage account (containers: bronze, silver, gold), Data Factory, Databricks workspace and Synapse workspace.
2. Import the pipeline from `adf/` and run it to load the bronze layer.
3. Register an app in Entra ID, give it the *Storage Blob Data Contributor* role on the storage account, and add your own IDs and secret to the notebook placeholders.
4. Run the notebook to produce the silver layer.
5. Run the scripts in `synapse/` in order (`01_create_schema.sql`, then `02_create_gold_views.sql`).
6. Connect Power BI to the Synapse serverless SQL endpoint.

## Notes

- Credentials in the notebook are replaced with placeholders.
- Dataset: [Microsoft AdventureWorks sample data](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure).
