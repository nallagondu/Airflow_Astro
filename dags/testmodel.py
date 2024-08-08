from airflow.decorators import dag, task
from datetime import datetime
import pandas as pd
import requests

dataset_url = 'https://raw.githubusercontent.com/FlipRoboTechnologies/ML_-Datasets/main/Insurance%20Claim%20Fraud%20Detection/Automobile_insurance_fraud.csv'

@dag(
    start_date=datetime(2023, 1, 1),
    schedule_interval='@daily',
    catchup=False,
    tags=['model_prediction']
)
def model_prediction_dag():
    
    @task
    def load_data():
        # Download the dataset
        response = requests.get(dataset_url)
        with open('/tmp/Automobile_insurance_fraud.csv', 'wb') as f:
            f.write(response.content)
        
        # Load the dataset into a DataFrame
        data = pd.read_csv('/tmp/Automobile_insurance_fraud.csv')
        return data

    @task
    def run_prediction(data):
        from scripts.predict import predict  # Ensure this path is correct
        predictions = predict(data)
        return predictions

    @task
    def handle_results(predictions):
        # Handle your predictions here (e.g., save to a database)
        print(predictions)

    data = load_data()
    predictions = run_prediction(data)
    handle_results(predictions)

model_prediction_dag()
