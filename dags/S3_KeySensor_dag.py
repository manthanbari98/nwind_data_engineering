from airflow.sdk import dag,task,asset
from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor
import pendulum


@dag(
    dag_id="customers_sensor_dag",
    schedule=None,
    start_date=pendulum.datetime(
        2026, 8, 12, tz="Asia/Kolkata"
    ),
    catchup=False,
    tags=["customers","s3"],
)

def customers_sensor_dag():
    wait_for_customers_file = S3KeySensor(
        task_id="wait_for_customers_file",
        bucket_name="manthan27",
        bucket_key="N_Wind/customers/*.csv",
        wildcard_match=True,
        aws_conn_id="aws_default",
        poke_interval=30,
        timeout=300,
        mode="poke",
    )

    @task
    def process_customers():
        print("S3 file found. Start processing...")

    wait_for_customers_file >> process_customers()

customers_sensor_dag()

