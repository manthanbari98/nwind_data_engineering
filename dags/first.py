from airflow.sdk import dag,task

@dag(
    dag_id = "first_dag"
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