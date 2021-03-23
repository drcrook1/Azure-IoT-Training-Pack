from flask import Flask
import os



def create_app():
    app = Flask(__name__)

    from webapp.apis.views import views
    app.register_blueprint(views)

    from webapp.apis.simulate import simulate
    app.register_blueprint(simulate)

    from webapp.apis.timeseries import timeseries
    app.register_blueprint(timeseries)

    return app