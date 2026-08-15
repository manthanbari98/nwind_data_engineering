# airflow image
FROM apache/airflow:3.2.0

# root user for gcc compiler for requirements that needs c
USER root

RUN apt-get update && apt-get install -y gcc && apt-get clean

# back to airflow user
USER airflow

#COPY requirements
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt