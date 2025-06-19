from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager
import os

# Инициализация расширений
db = SQLAlchemy()
migrate = Migrate()
login = LoginManager()
login.login_view = 'auth.login'

def create_app():

    app = Flask(__name__)

    config_path = os.path.join(os.path.dirname(__file__), '..', 'config.py')
    app.config.from_pyfile(config_path)

    db.init_app(app)
    migrate.init_app(app, db)
    login.init_app(app)

    from app.views import main_bp
    app.register_blueprint(main_bp)

    from app.views import auth_bp
    app.register_blueprint(auth_bp, url_prefix='/auth')

    return app
