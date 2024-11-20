import os
from datetime import datetime, timedelta

import scrapbook as sb

from airflow import DAG
from airflow.decorators import task
from airflow.lineage import AUTO
from airflow.providers.papermill.operators.papermill import PapermillOperator

START_DATE = datetime(2024, 11, 20)
SCHEDULE_INTERVAL = '0 0 1 * *'
DAGRUN_TIMEOUT = timedelta(minutes=60)

with DAG(
    dag_id='ETL_Melodi',
    schedule_interval=SCHEDULE_INTERVAL,
    start_date=START_DATE,
    dagrun_timeout=DAGRUN_TIMEOUT,
    tags=['melodi', 'etl'],
    catchup=False,
) as dag:
    # Task 1
    run_task_1 = PapermillOperator(
        task_id="Extract_IMDb",
        input_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/Extract/IMDb.ipynb",
        output_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/OutputAirflow/Extract/IMDb/IMDb-{{ execution_date }}.ipynb",
        parameters={"msgs": "Ran from Airflow at {{ execution_date }}!"},
    )

    # Task 2
    run_task_2 = PapermillOperator(
        task_id="Extract_OMDb_Utelly",
        input_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/Extract/OMDb_Utelly.ipynb",
        output_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/OutputAirflow/Extract/OMDb_Utelly/OMDb_Utelly-{{ execution_date }}.ipynb",
        parameters={"msgs": "Ran from Airflow at {{ execution_date }}!"},
    )
    
    # Task 3
    run_task_3 = PapermillOperator(
        task_id="Extract_uNoGS",
        input_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/Extract/uNoGS.ipynb",
        output_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/OutputAirflow/Extract/uNoGS/uNoGS-{{ execution_date }}.ipynb",
        parameters={"msgs": "Ran from Airflow at {{ execution_date }}!"},
    )
    
    # Task 4
    run_task_4 = PapermillOperator(
        task_id="Transform",
        input_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/Transform/Transform.ipynb",
        output_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/OutputAirflow/Transform/Transform-{{ execution_date }}.ipynb",
        parameters={"msgs": "Ran from Airflow at {{ execution_date }}!"},
    )
    
    # Task 5
    run_task_5 = PapermillOperator(
        task_id="Load_PostgreSQL_Tables",
        input_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/Load/SQL_Table/PostgreSQL_Tables.ipynb",
        output_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/OutputAirflow/Load/PostgreSQL_Tables/PostgreSQL_Tables-{{ execution_date }}.ipynb",
        parameters={"msgs": "Ran from Airflow at {{ execution_date }}!"},
    )
    
    # Task 6
    run_task_6 = PapermillOperator(
        task_id="Load_Loading_Postgres",
        input_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/Load/SQL_Table/Loading_Postgres.ipynb",
        output_nb="/home/demeter/Documents/airflow-environment/ETL-Melodi/OutputAirflow/Load/Loading_Postgres/Loading_Postgres-{{ execution_date }}.ipynb",
        parameters={"msgs": "Ran from Airflow at {{ execution_date }}!"},
    )

    # Set task dependencies
    run_task_1 >> run_task_2 >> run_task_3 >> run_task_4 >> run_task_5 >> run_task_6

