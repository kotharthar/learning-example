# Example

## Goals

## Learning Plan

## Weekly Resources

### Week1 

#### Data Sources

We are going to use the [Wallet Sales Forecast](https://www.kaggle.com/datasets/aslanahmedov/walmart-sales-forecast) data set for Week 1 exercise.

#### Core Concepts

### Week 2

#### Data Sources

We are going to use the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) data set for Week 2 exercise.

#### Core Concepts

- Demonstrate the whole Data Pipeline from OLTP to OLAP and data visualization
- Demonstrate the ML pipeline from data ingestion to ML Model training with Unsuperivsed Learning
- Demonstrate AutoML using H2O.ai

Steps
- Display the data in the OLTP database | Use Pgadmin
- Display the data in the OLTP database | Use Superset (Show 1 or 2 example visualization)
- Decide on ETL Processing example on current data set. Then create a new table in OLAP database and load the data into it. (How to do that from Postgresql to Clickhouse using Nifi)
- Display the data in the OLAP database | Use Superset (Show 1 or 2 example visualization)

#### How to run environment

- Install `docker` and `docker-compose` on your machine.
- Go into Week2 folder.
- Run `docker-compose up -d` to start the environment.
- Make sure to run the followings to set the `Superset` properly.

```bash
docker exec -it superset superset fab create-admin \
              --username zarla \
              --firstname Zarla \
              --lastname Admin \
              --email admin@zarla.com \
              --password zarla1234
```