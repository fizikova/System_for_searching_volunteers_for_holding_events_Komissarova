import sys
import os

# Указываем путь к корню проекта, чтобы Python мог найти пакет app
project_home = os.path.abspath(os.path.dirname(__file__))
if project_home not in sys.path:
    sys.path.insert(0, project_home)

# Импортируем фабрику приложения и создаём экземпляр
from app import create_app
application = create_app()
