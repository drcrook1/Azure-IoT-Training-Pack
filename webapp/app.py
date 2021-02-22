from flask import Flask

SQL_AZURE_CONN_STR = ""

def create_app():
    app = Flask(__name__)

    from webapp.apis.simulate import simulate
    app.register_blueprint(simulate)

    global SQL_AZURE_CONN_STR
    SQL_AZURE_CONN_STR = "whateverconnstr"

    return app