from app.controllers.application import Application
from bottle import Bottle, route, run, request, static_file
from bottle import redirect, template, response


app = Bottle()
ctl = Application()


#-----------------------------------------------------------------------------
# Rotas:

@app.route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root='./app/static')

@app.route('/helper')
def helper():
    return ctl.render('helper')

@app.route('/pagina', methods=['GET'])
@app.route('/pagina/<username>', methods=['GET'])
def action_pagina(username=None):
    if not username:
        return ctl.render('pagina')
    else:
        return ctl.render('pagina', username)


@app.route('/portal', method='GET')
def login():
    return ctl.render('portal')


@app.route('/portal', method='POST')
def action_portal(): 
    username = request.forms.get('username') 
    password = request.forms.get('password') 
    auth_result = ctl.authenticate_user(username, password) 
    
    if auth_result is not None: 
        session_id, username = auth_result
        response.set_cookie('session_id', session_id, httponly=True, secure=True, max_age=3600)
        redirect(f'/blog/{username}')
    else: 
        return redirect('/portal')


@app.route('/logout', method='POST')
def logout():
    session_id = request.get_cookie("session_id")  # Obtém o ID da sessão atual
    if session_id:
        ctl.logout_user()  # Chama o método de logout para remover a sessão
        response.delete_cookie("session_id")  # Remove o cookie de sessão do cliente
    return redirect('/inicio')  # Redireciona para a página inicial

    

#-----------------------------------------------------------------------------
# Suas rotas aqui:

@app.route('/inicio', method=['GET', 'POST'])
def inicio():
    return ctl.render('inicio')

@app.route('/blog', methods=['GET']) ## criar uma página com as mesmas verificações da página 
@app.route('/blog/<username>', methods=['GET'])
def action_blog(username=None):
    if not username:
        return ctl.render('blog')
    else:
        return ctl.render('blog', username)

@route('/cadastro', method='GET')
def cadastro():
    return ctl.render('cadastro')

@route('/cadastro', method='POST')
def action_cadastro():
    username = request.forms.get('username')
    password = request.forms.get('password')
    name = request.forms.get('name')
    age = request.forms.get('age')
    email = request.forms.get('email')
    
    ctl.action_book(username, password, name, age, email)



#-----------------------------------------------------------------------------


if __name__ == '__main__':

    run(app, host='localhost', port=8080, debug=True)
