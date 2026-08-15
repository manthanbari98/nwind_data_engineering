# NWind Data Engineering Project

An end-to-end data engineering project built using **Databricks, PySpark, dbt, and Apache Airflow**.

The project implements a **Medallion Architecture** with Bronze, Silver, and Gold layers, with Apache Airflow used for workflow orchestration and dbt used for data transformation and modeling.


## 🏗️ Architecture

```text
              Databricks Volume
                     │
                     ▼
              Apache Airflow
                     │
                     ▼
                Databricks
                     │
              ┌──────┴──────┐
              ▼             ▼
           Bronze       Source Freshness
              │
              ▼
           Silver
              │
              ▼
            Gold
              │
        ┌─────┴─────┐
        ▼           ▼
   Dimensions      Facts

```
## 🚀 Technologies

| Technology | Purpose |
|---|---|
| **Databricks** | Data processing and lakehouse environment |
| **Databricks Volumes** | Source data storage |
| **PySpark** | Data processing and transformations |
| **dbt** | SQL transformations and data modeling |
| **Apache Airflow** | Workflow orchestration and scheduling |
| **Delta Lake** | Lakehouse storage |
| **Docker** | Local Airflow environment |
| **Git/GitHub** | Version control |


## 📂 Project Structure

```text
nwind_data_engineering/
│
├── dags/
└── dag_orchestration.py

│
├── nwind_project/
│   ├── dbt_project.yml
│   ├── macros/
│   ├── models/
│   │   ├── source/
│   │   ├── bronze/
│   │   ├── silver/
│   │   └── gold/
│   ├── snapshots/
│   ├── analyses/
│   ├── seeds/
│   └── tests/
│
├── Dockerfile
├── docker-compose.yaml
├── .gitignore
├── LICENSE
└── README.md
```

## 🥉 Bronze Layer

The Bronze layer contains the initial data models from the source data.

It includes models for:

- Customers
- Orders
- Order Details
- Products
- Employees
- Categories
- Shippers
- Suppliers
- Shipments

---

## 🥈 Silver Layer

The Silver layer contains cleaned and transformed and joined data prepared for downstream analytical models.

It includes models for:

- Customers
- Employees
- Orders
- Products
- Shippers

---

## 🥇 Gold Layer

The Gold layer contains analytical models using fact and dimension tables.

### Dimension Tables

- `dim_customers`
- `dim_employees`
- `dim_products`
- `dim_shipments`

### Fact Table

- `fact_orders`


## 🔄 dbt

The project uses **dbt** to build and manage the data transformation layers.

The dbt project is organized into:

```text
nwind_project/
│
├── models/
│   ├── source/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── snapshots/
├── macros/
├── analyses/
├── seeds/
└── tests/
```

## 🔄 Apache Airflow

Apache Airflow is used to orchestrate the data engineering workflow.

The main orchestration DAG manages the execution flow between the different stages of the pipeline.

The workflow is designed around task dependencies:

```text
Data Ingestion
      ↓
Source Freshness
      ↓
Bronze
      ↓
Silver
      ↓
Gold
      ↓
Snapshots
```

## 📸 dbt Snapshots

The project includes dbt snapshots to track historical changes in data over time.

Current snapshots include:

- `customer_snapshot.sql`
- `product_snapshot.yml`

Snapshots help maintain historical versions of records when tracked data changes.

## 🐳 Docker

The Airflow environment is configured to run locally using Docker.

The repository includes:

- `Dockerfile`
- `docker-compose.yaml`

Docker is used to provide a reproducible local environment for Apache Airflow.

---

## ▶️ Running the Project

### 1. Clone the repository

```bash
git clone https://github.com/manthanbari98/nwind_data_engineering.git
cd nwind_data_engineering
```
## 🎯 Key Features

This project demonstrates:

- Medallion Architecture
- Bronze, Silver and Gold data layers
- Databricks Volumes for source data
- PySpark data processing
- dbt transformations and data modeling
- Fact and dimension modeling
- dbt snapshots for historical tracking
- dbt source freshness checks
- Apache Airflow orchestration
- Airflow scheduling and task dependencies
- Dockerized Airflow environment
- Git and GitHub version control

---

## 🔐 Security

Credentials and sensitive configuration are not stored in the repository.

Sensitive files such as:

```text
.env
profiles.yml
```

## 👨‍💻 Author

**Manthan Bari**