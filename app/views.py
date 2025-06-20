from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, login_required, current_user
from sqlalchemy import func
from app.models import Event

main_bp = Blueprint('main', __name__)

def get_accepted_count(event):
    return len([r for r in event.registrations if r.status == 'accepted'])

@main_bp.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    pagination = Event.query \
        .filter(Event.date >= func.current_date()) \
        .order_by(Event.date.desc()) \
        .paginate(page=page, per_page=10, error_out=False)
    events = pagination.items
    return render_template('index.html',
                           events=events,
                           pagination=pagination,
                           get_accepted_count=get_accepted_count)

auth_bp = Blueprint('auth', __name__)

from app.forms import LoginForm
from app.models import User
from werkzeug.security import check_password_hash

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(login=form.login.data).first()
        if user and check_password_hash(user.password_hash, form.password.data):
            login_user(user, remember=form.remember_me.data)
            return redirect(request.args.get('next') or url_for('main.index'))
        flash('Неверный логин или пароль')
    return render_template('login.html', form=form)

@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Вы вышли из системы')
    return redirect(request.args.get('next') or url_for('main.index'))
