import os 
from dotenv import load_dotenv
from pathlib import Path

class EnvironmentDecisionHelper:
    
    def __init__(self):
        raise RuntimeError('Call set_environment_settings instead')

    @staticmethod
    def set_environment_settings():
        if os.environ.get("ENVIRONMENT").lower() == "development":
            env_path = Path('.') / 'local.env'
            load_dotenv(env_path)
        elif os.environ.get("ENVIRONMENT").lower() == "production":
            env_path = Path('.') / 'production.env'     
            load_dotenv(env_path)
        else:
            raise Exception("No ENVIRONMENT variable set")
