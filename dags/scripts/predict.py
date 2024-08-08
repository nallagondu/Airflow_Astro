import pickle
import pandas as pd
import os

def predict(input_data):
    try:
        # Construct the relative path to the model file
        model_path = os.path.join(os.path.dirname(__file__), '..', 'AI_models', 'Gradient_model.pkl')
        
        # Load the model
        with open(model_path, 'rb') as f:
            model = pickle.load(f)
        print("Model loaded successfully.")
        
        # Validate input data
        if not isinstance(input_data, pd.DataFrame):
            raise ValueError("Input data should be a pandas DataFrame.")
        
        # Convert date columns to numeric format
        if 'date_column' in input_data.columns:
            input_data['date_column'] = pd.to_datetime(input_data['date_column'], format='%d-%m-%Y').astype(int) / 10**9
        
        # Make predictions
        predictions = model.predict(input_data)
        print("Predictions made successfully.")
        
        return predictions
    
    except Exception as e:
        print(f"An error occurred: {e}")
        raise
