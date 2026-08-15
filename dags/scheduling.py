from airflow.sdk import dag,task
from datetime import datetime

@dag(
    dag_id = "first_dag",
    start_date=datetime(2026,8,12),
    schedule=@daily

)
def first_dag():

    @task.python
    def first_task():
        print("first-dag")

    @task.python
    def second_task():
        print("second-task")

    first = first_task()
    second = second_task()

    first >> second

first_dag()