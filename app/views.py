from flask import Blueprint, render_template, redirect, url_for, flash, request, abort, current_app
from flask_login import login_user, logout_user, login_required, current_user
from sqlalchemy import func
from werkzeug.utils import secure_filename
import os, bleach

from app import db
from app.models import Event, User, Registration, Role
from app.forms import LoginForm, EventForm
from werkzeug.security import check_password_hash

ALLOWED_TAGS = bleach.sanitizer.ALLOWED_TAGS.union(
    {'p', 'pre', 'h1', 'h2', 'h3', 'ul', 'ol', 'li', 'strong', 'em', 'a'}
)

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

@main_bp.route('/event/create', methods=['GET', 'POST'])
@login_required
def create_event():
    if current_user.role.name not in ('admin', 'moderator'):
        flash('У вас недостаточно прав для создания мероприятия')
        return redirect(url_for('main.index'))

    form = EventForm()
    if form.validate_on_submit():
        filename = secure_filename(form.image.data.filename)
        upload_path = os.path.join(current_app.static_folder, 'uploads', filename)
        form.image.data.save(upload_path)
        desc_html = bleach.clean(form.description.data, tags=ALLOWED_TAGS, strip=True)

        ev = Event(
            name=form.name.data,
            description=desc_html,
            date=form.date.data,
            place=form.place.data,
            volunteers_required=form.volunteers_required.data,
            image_filename=filename,
            organizer_id=current_user.id
        )
        db.session.add(ev)
        db.session.commit()
        return redirect(url_for('main.event_detail', event_id=ev.id))

    return render_template('event_form.html', form=form, event=None)

@main_bp.route('/event/<int:event_id>/edit', methods=['GET', 'POST'])
@login_required
def edit_event(event_id):
    ev = Event.query.get_or_404(event_id)
    if current_user.role.name not in ('admin', 'moderator'):
        flash('У вас недостаточно прав для редактирования')
        return redirect(url_for('main.index'))

    class EditForm(EventForm):
        image = None

    form = EditForm(obj=ev)
    if form.validate_on_submit():
        ev.name = form.name.data
        ev.description = bleach.clean(form.description.data, tags=ALLOWED_TAGS, strip=True)
        ev.date = form.date.data
        ev.place = form.place.data
        ev.volunteers_required = form.volunteers_required.data
        db.session.commit()
        return redirect(url_for('main.event_detail', event_id=ev.id))

    return render_template('event_form.html', form=form, event=ev)

@main_bp.route('/event/<int:event_id>/delete', methods=['POST', 'GET'])
@login_required
def delete_event(event_id):
    ev = Event.query.get_or_404(event_id)
    if current_user.role.name != 'admin':
        abort(403)
    db.session.delete(ev)
    db.session.commit()
    flash('Мероприятие удалено')
    return redirect(url_for('main.index'))

@main_bp.route('/event/<int:event_id>')
def event_detail(event_id):
    ev = Event.query.get_or_404(event_id)
    return render_template('event_detail.html', event=ev)

@main_bp.route('/event/<int:event_id>/register', methods=['POST'])
@login_required
def register(event_id):
    ev = Event.query.get_or_404(event_id)
    if any(r.volunteer_id == current_user.id for r in ev.registrations):
        flash('Вы уже подали заявку на это мероприятие')
    else:
        contact = request.form.get('contact_info', '').strip()
        if not contact:
            flash('Укажите контактную информацию')
        else:
            reg = Registration(
                event_id=ev.id,
                volunteer_id=current_user.id,
                contact_info=contact
            )
            db.session.add(reg)
            db.session.commit()
            flash('Ваша заявка отправлена на модерацию')
    return redirect(url_for('main.event_detail', event_id=ev.id))

@main_bp.route('/registration/<int:reg_id>/accept')
@login_required
def accept_registration(reg_id):
    reg = Registration.query.get_or_404(reg_id)
    if current_user.role.name not in ('admin', 'moderator'):
        abort(403)
    reg.status = 'accepted'
    db.session.commit()
    ev = reg.event
    if get_accepted_count(ev) >= ev.volunteers_required:
        for p in ev.registrations:
            if p.status == 'pending':
                p.status = 'rejected'
        db.session.commit()
    return redirect(url_for('main.event_detail', event_id=ev.id))

@main_bp.route('/registration/<int:reg_id>/reject')
@login_required
def reject_registration(reg_id):
    reg = Registration.query.get_or_404(reg_id)
    if current_user.role.name not in ('admin', 'moderator'):
        abort(403)
    reg.status = 'rejected'
    db.session.commit()
    return redirect(url_for('main.event_detail', event_id=reg.event_id))

# ---------------------
# Аутентификация
# ---------------------
auth_bp = Blueprint('auth', __name__)

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