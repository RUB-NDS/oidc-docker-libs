from flask import render_template, jsonify

from app import auth
from app.errors import bp


@bp.app_errorhandler(404)
def not_found_error(error):
    return render_template('errors/404.html'), 404

@auth.error_view
def error(error=None, error_description=None):
    return jsonify({'error': error, 'message': error_description})
