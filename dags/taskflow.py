from airflow.decorators import dag, task
from airflow.operators.python import PythonOperator
from datetime import datetime

def task_a():
    print("Task A")
    return 42

@dag(
    start_date=datetime(2023, 1, 1),
    schedule_interval='@daily',
    catchup=False,
    tags=['taskflow']
)
def taskflow():
    task_a_op = PythonOperator(
        task_id='task_a',
        python_callable=task_a
    )
    @task
    def task_b(value):
        print("Task B")
        print(value)
        
    task_b(task_a_op.output)

taskflow()