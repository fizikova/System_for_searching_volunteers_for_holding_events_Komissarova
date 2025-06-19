from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager
import os

# Инициализируем расширения
# (не меняйте эти строки)
db = SQLAlchemy()
migrate = Migrate()
login = LoginManager()
login.login_view = 'auth.login'  # где перенаправлять неавторизованных


def create_app():
    # Создаём приложение Flask
    app = Flask(__name__, instance_relative_config=False)

    # Загружаем конфиг из файла
    # Поменяйте путь на свой:
    # 1) Локально на Windows:
    #    app.config.from_pyfile(r'C:\vyz\Volunteering\config.py')
    # 2) На PythonAnywhere (config.py в корне проекта):
    #    app.config.from_pyfile('config.py')
    app.config.from_pyfile('config.py')   # <-- УКАЖИТЕ ЗДЕСЬ СВОЙ ПУТЬ К config.py

    # Инициализация расширений
    db.init_app(app)
    migrate.init_app(app, db)
    login.init_app(app)

    # Регистрируем маршруты через Blueprint-ы
    from app.views import main_bp
    app.register_blueprint(main_bp)
    from app.views import auth_bp
    app.register_blueprint(auth_bp, url_prefix='/auth')

    return app

