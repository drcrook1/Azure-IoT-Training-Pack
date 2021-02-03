from flask import Flask

def create_app():
    app = Flask(__name__)

    from webapp.apis.simulate import simulate
    app.register_blueprint(simulate)

    return app