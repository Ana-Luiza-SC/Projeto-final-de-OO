<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #6c3483;
            color: white;
            height: 50px;
            display: flex;
            align-items: center;
            font-family: 'Oswald', sans-serif;
            padding: 0 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar table {
            width: 100%;
            border-collapse: collapse;
        }
        .navbar td {
            vertical-align: middle;
            padding: 0 20px;
        }
        .navbar h1 {
            margin: 0;
            font-size: 20px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
            display: inline-block;
            line-height: 30px;
            font-size: 16px;
        }
        .navbar a:hover {
            background-color: #4a235a;
        }

        .content {
            padding-top: 100px; /* Adiciona espaçamento suficiente para que o conteúdo não fique oculto */
            text-align: center;
        }

        .content h2 {
            color: #4a235a;
            font-size: 24px;
            margin-bottom: 10px;
            font-family: 'Oswald', sans-serif;
            text-align: center; 
        }

        .content h3 {
            color: #4a235a;
            font-size: 20px;
            margin-bottom: 10px;
            font-family: 'Oswald', sans-serif;
            text-align: center; 
        }

        /* Estilização para o conteúdo dos posts */
        .content p {
            font-size: 18px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
            text-align: center; 
        }
        
        
        .content .button-center {
            display: flex; /* Usa flexbox para centralizar o botão */
            justify-content: center; /* Centraliza horizontalmente */
            margin: 20px 0; /* Espaçamento vertical */
        }

        /* Estilização para o link de criação de novos posts */
        .content a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c3483;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-family: 'Roboto', sans-serif;
            font-size: 16px;
            margin: 20px auto;
            text-align: center; 
        }

        .content a:hover {
            background-color: #4a235a;
        }
    </style>
</head>
<h1>Painel de Administração</h1>
<table>
    <tr>
        <th>Username</th>
        <th>Nome</th>
        <th>Idade</th>
        <th>Email</th>
        <th>Tipo</th>
        <th>Ações</th>
    </tr>
    % for user in users:
    <tr>
        <td>{{ user.username }}</td>
        <td>{{ user.name }}</td>
        <td>{{ user.age }}</td>
        <td>{{ user.email }}</td>
        <td>{{ user.type }}</td>
        <td>
            <form action="/edit_user/{{ user.username }}" method="POST">
                <button type="submit">Editar</button>
            </form>
            <form action="/delete_user/{{ user.username }}" method="POST">
                <button type="submit">Excluir</button>
            </form>
        </td>
    </tr>
    % end
</table>

<h2>Adicionar Novo Usuário</h2>
<form action="/add_user" method="POST">
    <input type="text" name="username" placeholder="Username" required>
    <input type="password" name="password" placeholder="Senha" required>
    <input type="text" name="name" placeholder="Nome">
    <input type="number" name="age" placeholder="Idade">
    <input type="email" name="email" placeholder="Email">
    <select name="type">
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select>
    <button type="submit">Adicionar</button>
</form>