#! /bin/bash

source .env/bin/activate
export AIRFLOW_HOME=$(pwd)/airflow

airflow webserver &
airflow scheduler &