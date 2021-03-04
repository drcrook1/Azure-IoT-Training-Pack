from flask import Flask
import os

SQL_AZURE_CONN_STR = ""

def create_app():

    if(os.environ["ENV"] == "DEV"):
        load_dev()
    else:
        load_prod()

    app = Flask(__name__)

    from webapp.apis.views import views
    app.register_blueprint(views)

    from webapp.apis.simulate import simulate
    app.register_blueprint(simulate)

    return app

def load_dev():
    global SQL_AZURE_CONN_STR
    SQL_AZURE_CONN_STR = os.environ["SQL_AZURE_CONN_STR"]
    return None

def load_prod():
    return None