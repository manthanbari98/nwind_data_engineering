from databricks.sdk.service.jobs import RunLifeCycleState,RunResultState
from databricks.sdk import WorkspaceClient
import time

ws = WorkspaceClient(
    host = "DATABRICKS_HOST",
    token = "DATABRICKS_TOKEN"
    )

job_trigger = ws.jobs.run_now(job_id="887064911894755")

print("job_trigged")

while True:
    job_run = ws.jobs.get_run(job_trigger.run_id)

    if job_run.state.life_cycle_state in [RunLifeCycleState.TERMINATED,RunLifeCycleState.SKIPPED,RunLifeCycleState.INTERNAL_ERROR]:

        if job_run.state.result_state == RunResultState.SUCCESS:
            print("JOB COMPLETED SUCCESSFULLY!!")
            break

        else:
            raise Exception(f"Job failed with state : {job_run.state.result_state}")

    time.sleep(10)
    print("running...")