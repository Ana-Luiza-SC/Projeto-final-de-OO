from app.controllers.application import Application
from app.controllers.datarecord import DataRecord, Post 
from bottle import Bottle, route, run, request, static_file
from bottle import redirect, template, response
from datetime import date


app = Bottle()
ctl = Application()


#-----------------------------------------------------------------------------
# Rotas:

# @app.route('/static/<filepath:path>')
# def serve_static(filepath):
#     return static_file(filepath, root='./app/static')

# @app.route('/helper')
# def helper():
#     return ctl.render('helper')

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
        redirect(f'/blog')
    else: 
        return redirect('/portal')

@app.route('/logout', method='POST')
def logout():
    session_id = request.get_cookie("session_id")  # Obtém o ID da sessão atual
    if session_id:
        ctl.logout_user()  # Chama o método de logout para remover a sessão
        response.delete_cookie("session_id")  # Remove o cookie de sessão do cliente
    return redirect('/')  # Redireciona para a página inicial

    

#-----------------------------------------------------------------------------
# Suas rotas aqui:

@app.route('/', method=['GET', 'POST'])
def inicio():
    return ctl.render('inicio')

@app.route('/blog', method=['GET', 'POST'])
def blog():
    return ctl.render('blog')


@app.route('/cadastro', method='GET')
def cadastro():
    return ctl.render('cadastro')

@app.route('/cadastro', method='POST')
def action_cadastro():
    username = request.forms.get('username')
    password = request.forms.get('password')
    name = request.forms.get('name')
    age = request.forms.get('age')
    email = request.forms.get('email')
    
    ctl.action_book(username, password, name, age, email)
    redirect(f'/portal')

@app.route('/novo_post', method='GET')
def novo_post():
    return ctl.render('novo_post')

@app.route('/novo_post', method='POST')
def action_novo_post():
    autor = request.forms.get('Autor')
    titulo = request.forms.get('Titulo')
    conteudo = request.forms.get('Conteudo')
    data = date.today().strftime('%Y-%m-%d')
    
    if not autor or not titulo or not conteudo:
        return "Todos os campos são obrigatórios."

    ctl.action_post(autor, titulo, conteudo, data)
    return redirect('/blog')

@app.route('/area', method=['GET', 'POST'])
def administrador():
    return ctl.render('adm')

@app.route('/add_user', method='POST')
def add_user():
    username = request.forms.get('username')
    password = request.forms.get('password')
    name = request.forms.get('name')
    age = request.forms.get('age')
    email = request.forms.get('email')
    user_type = request.forms.get('type')
    return ctl.add_user(username, password, name, age, email, user_type)

@app.route('/edit_user/<username>', method='POST')
def edit_user(username):
    new_data = {
        'password': request.forms.get('password'),
        'name': request.forms.get('name'),
        'age': request.forms.get('age'),
        'email': request.forms.get('email'),
        'type': request.forms.get('type')
    }
    return ctl.edit_user(username, new_data)

@app.route('/delete_user/<username>', method='POST')
def delete_user(username):
    return ctl.delete_user(username)



if __name__ == '__main__':
    run(app, host='localhost', port=8080, debug=True)
