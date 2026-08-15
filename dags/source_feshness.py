from airflow.sdk import dag,task
from airflow.providers.standard.operators.bash import BashOperator

@dag(
    dag_id = "source_check"
)
def source_check():
    remove_target = BashOperator(
        task_id="remove_target",
        cwd="/opt/airflow/nwind_project",
        bash_command="rm -rf target"
    )

    source_freshness = BashOperator(
        task_id = 'source_freshness',
        cwd = '/opt/airflow/nwind_project',
        bash_command='dbt source freshness'
    )
    remove_target >> source_freshness

source_check()