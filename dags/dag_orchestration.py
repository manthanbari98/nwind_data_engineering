from airflow.sdk import dag,task
from airflow.providers.standard.operators.bash import BashOperator
from databricks.sdk.service.jobs import RunLifeCycleState,RunResultState
from databricks.sdk import WorkspaceClient
from datetime import datetime
import time

@dag(
    dag_id="orchestator_dag",
    schedule="@hourly",
    start_date=datetime(2026, 8, 14),
    catchup=False
)
def orchestrator_dag():

    @task
    def ingest_data():
        ws = WorkspaceClient(
                host = "DATABRICKS_HOST",
                token = "DATABRICKS_TOKEN"
                )

        job_trigger = ws.jobs.run_now(job_id="641579812855266")

        print("job_trigged")

        while True:
            job_run = ws.jobs.get_run(job_trigger.run_id)

            if job_run.state.life_cycle_state in [
                RunLifeCycleState.TERMINATED,
                RunLifeCycleState.SKIPPED,
                RunLifeCycleState.INTERNAL_ERROR
                ]:

                if job_run.state.result_state == RunResultState.SUCCESS:
                    print("JOB COMPLETED SUCCESSFULLY!!")
                    break

                else:
                    raise Exception(f"Job failed with state : {job_run.state.result_state}")

            time.sleep(10)

    @task.bash
    def remove_target():
        return"rm -rf /opt/airflow/nwind_project/target"

    source_freshness = BashOperator(
        task_id="source_freshness",
        cwd="/opt/airflow/nwind_project",
        bash_command="dbt source freshness"
    )

    bronze_model_build = BashOperator(
        task_id="bronze_model_build",
        cwd="/opt/airflow/nwind_project",
        bash_command="dbt build --select bronze"
    )

    silver_model_build = BashOperator(
        task_id = "silver_model_build",
        cwd = "/opt/airflow/nwind_project",
        bash_command = "dbt build --select silver"
    )

    snapshot_run = BashOperator(
        task_id = "snapshot_run",
        cwd = "/opt/airflow/nwind_project",
        bash_command = "dbt snapshot"
    )

    gold_model_build = BashOperator(
        task_id = "gold_model_build",
        cwd = "/opt/airflow/nwind_project",
        bash_command = "dbt build --select gold"
    )

    ingest_data() >> remove_target() >> source_freshness >>bronze_model_build >> silver_model_build >> snapshot_run >> gold_model_build

orchestrator_dag()
    
