from app import create_app, auth

app = create_app()

@app.route('/logout')
@auth.oidc_logout
def logout():
    return render_template('logout.html',
                           title=('Logout')
                           )

if __name__ == '__main__':
    app.run()

