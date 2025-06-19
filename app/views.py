from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, login_required, current_user

# Blueprint для основных (главная, просмотр, CRUD мероприятий)
main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def index():
    # здесь позже будет логика получения списка events
    return render_template('index.html')

# Blueprint для аутентификации (вход/выход)
auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    # здесь позже будет форма и логика аутентификации
    return render_template('login.html')

@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Вы вышли из системы')
    return redirect(request.args.get('next') or url_for('main.index'))
