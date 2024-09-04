from bottle import Bottle, request, redirect, response, template, static_file
from app.controllers.application import Application
from datetime import date
import re 

app = Bottle()
ctl = Application()

def sanitize_string(s):
    return re.sub(r'[^\w-]', '', s.replace(' ', '_'))
    
# Serve static files from the 'app/static' directory
@app.route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root='./app/static')

# ---------- Helper Pages ------------------------------------------------------

@app.route('/helper')
def helper():
    return ctl.render('helper')

# ---------- User Pages --------------------------------------------------------

@app.route('/pagina', methods=['GET'])
def action_pagina(username=None):
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('pagina')

@app.route('/portal', method='GET')
def login():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('portal')

@app.route('/portal', method='POST')
def action_portal():
    response.content_type = 'text/html; charset=utf-8'
    username = request.forms.get('username')
    password = request.forms.get('password')
    auth_result = ctl.authenticate_user(username, password)
    
    if auth_result is not None:
        response.content_type = 'text/html; charset=utf-8'
        session_id, username = auth_result
        response.set_cookie('session_id', session_id, httponly=True, secure=True, max_age=3600)
        redirect('/blog')
    else:
        return redirect('/portal')

@app.route('/logout', method='POST')
def logout():
    response.content_type = 'text/html; charset=utf-8'
    session_id = request.get_cookie("session_id")
    if session_id:
        ctl.logout_user()
        response.delete_cookie("session_id")
    return redirect('/')

@app.route('/', method=['GET', 'POST'])
def inicio():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('inicio')

@app.route('/blog', method=['GET', 'POST'])
def blog():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('blog')

# ---------- User Registration --------------------------------------------------

@app.route('/cadastro', method='GET')
def cadastro():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('cadastro')

@app.route('/cadastro', method='POST')
def action_cadastro():
    response.content_type = 'text/html; charset=utf-8'
    username = request.forms.get('username')
    password = request.forms.get('password')
    name = request.forms.get('name')
    age = request.forms.get('age')
    email = request.forms.get('email')
    
    ctl.action_book(username, password, name, age, email)
    return redirect('/portal')

# ---------- Post Management ---------------------------------------------------

@app.route('/post', method='GET')
def area_post():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('post')

@app.route('/novo_post', method='POST')
def action_novo_post():
    response.content_type = 'text/html; charset=utf-8'
    titulo = request.forms.get('Titulo')
    conteudo = request.forms.get('Conteudo')
    data = date.today().strftime('%Y-%m-%d')
    
    ctl.action_post(titulo, conteudo, data)
    return redirect('/blog')


@app.route('/post_adm', method='GET')
def post_control():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.render('post_control') 

@app.route('/delete_post/<post_title>', method='POST')
def delete_post(post_title):
    post_title =post_title 
    ctl.delete_post(post_title)
    return redirect('/post_adm')


@app.route('/edit_post/<post_title>', method='POST')
def edit_post(post_title):
    new_data = {
        'title': request.forms.get('titulo'),
        'conteudo': request.forms.get('conteudo'),
        'data': request.forms.get('data')
    }
    return ctl.edit_post(post_title, new_data)  # Passa o título e new_data como argumento

# ---------- Admin Pages --------------------------------------------------------

@app.route('/area_adm', method=['GET', 'POST'])
def administrador():
    response.content_type = 'text/html; charset=utf-8'
    return ctl.administrador()

@app.route('/add_user', method='POST')
def add_user():
    response.content_type = 'text/html; charset=utf-8'
    username = request.forms.get('username')
    password = request.forms.get('password')
    name = request.forms.get('name')
    age = request.forms.get('age')
    email = request.forms.get('email')
    user_type = request.forms.get('type')
    return ctl.add_user(username, password, name, age, email, user_type)

@app.route('/edit_user/<username>', method='POST')
def edit_user(username):
    response.content_type = 'text/html; charset=utf-8'
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
    response.content_type = 'text/html; charset=utf-8'
    return ctl.delete_user(username)

@app.route('/user_edit_user/<username>', method='POST')
def edit_user(username):
    response.content_type = 'text/html; charset=utf-8'
    new_data = {
        'password': request.forms.get('password'),
        'name': request.forms.get('name'),
        'age': request.forms.get('age'),
        'email': request.forms.get('email'),
        'type': request.forms.get('type')
    }
    return ctl.user_edit_user(username, new_data)


@app.route('/user_delete_user/<username>', method='POST')
def delete_user(username):
    response.content_type = 'text/html; charset=utf-8'
    return ctl.user_delete_user(username)


if __name__ == '__main__':
    app.run(host='localhost', port=8080, debug=True)
