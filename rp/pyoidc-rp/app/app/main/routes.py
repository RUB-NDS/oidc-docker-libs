from flask import render_template, redirect, url_for, session, json

from app import auth
from app.main import bp
from flask_pyoidc.user_session import UserSession, UninitialisedSession


@bp.route('/index', methods=['GET', 'POST'])
@bp.route('/', methods=['GET', 'POST'])
def index():
    try:
        user_session = UserSession(session)
        is_authorized = user_session.is_authenticated()
    except UninitialisedSession:
        is_authorized = False
    return render_template('index.html',
                           title=('Home'),
                           authorized=(is_authorized),
                           )


@bp.route('/login')
@auth.oidc_auth('default')     # must match with provider name in provider.json!
def login():
    user_session = UserSession(session)
    user_session.update(access_token=user_session.access_token,
             id_token=user_session.id_token,
             userinfo=user_session.userinfo)
    return redirect(url_for('main.profile'))


@bp.route('/profile')
def profile():
    try:
        user_session = UserSession(session)
        is_authorized = user_session.is_authenticated()
    except UninitialisedSession:
        print("Not authenticated!")
        redirect(url_for('main.index'))
    return render_template('profile.html',
                           title=('Profile'),
                           access_token=user_session.access_token,
                           id_token=user_session.id_token,
                           userinfo=user_session.userinfo,
                           authorized=(is_authorized)
                           )

@bp.route('/logout_test')
@auth.oidc_logout
def logout():
    return render_template('logout.html',
                           title=('Logout')
                           )
