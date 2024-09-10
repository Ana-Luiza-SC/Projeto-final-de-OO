<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página do Usuário</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #090D1F; /* Cor de fundo escura */
            color: #C0C5D0; /* Cor do texto */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #090D1F; /* Cor da navbar igual ao fundo */
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
            border: none;
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
            background-color: #273570;
        }

        .user-container {
            background-color: white; /* Fundo branco para o contêiner principal */
            border: 1px solid #ccc;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            text-align: center;
        }

        .user-container h2 {
            color: #090D1F;
            font-family: 'Oswald', sans-serif;
            margin-bottom: 20px;
        }

        .user-container p {
            font-size: 18px;
            color: #666;
            margin-bottom: 15px;
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container a, .button-container button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #090D1F;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-family: 'Roboto', sans-serif;
            font-size: 16px;
            margin: 5px;
            border: none;
            cursor: pointer;
        }

        .button-container a:hover, .button-container button:hover {
            background-color: #273570;
        }

        .edit-form {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background-color: white; /* Fundo branco */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .edit-form input {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-family: 'Roboto', sans-serif;
        }

        .edit-form button {
            width: 100%;
            padding: 10px;
            background-color: #090D1F;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: 'Roboto', sans-serif;
            transition: background-color 0.3s;
        }

        .edit-form button:hover {
            background-color: #273570;
        }
        .redirect-link {
            color: white; /* Cor do texto do link */
            text-decoration: none;
            padding: 10px 20px;
            background-color: #090D1F; /* Fundo branco */
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            display: inline-block;
            margin-top: 20px;
            font-family: 'Roboto', sans-serif;
            font-size: 16px;
        }

        .redirect-link:hover {
            background-color: #273570;
            color: white;
        }

    </style>
</head>
<body>

    <div class="navbar">
        <table>
            <tr>
                <td class="left"><h1>Área do Usuário</h1></td>
                <td class="right" align="right">
                %if transfered:
                    <a href="/blog">Blog</a>
                %end
                    % if current_user is not None and current_user.type == "adm":
                        <a href="/area_adm">Área do administrador</a>
                        <a href="/post">Criar Post</a>
                        <a href="/post_adm">Controle dos Posts</a>
                    %end
                </td>
            </tr>
        </table>
    </div>

    <div class="user-container">
        % if transfered:
            <h2>Dados do Usuário:</h2>
            <p>Username: {{current_user.username}}</p>
            <p>Nome: {{current_user.name}}</p>
            <p>Idade: {{current_user.age}}</p>
            <p>Email: {{current_user.email}}</p>
            <div class="button-container">
                <button type="button" onclick="toggleEditForm('{{ current_user.username }}')">Editar</button>
                <form action="/user_delete_user/{{ current_user.username }}" method="POST" style="display:inline;">
                    <button type="submit">Excluir</button>
                </form>
                <form action="/logout" method="post" style="display:inline;">
                    <button type="submit">Sair</button>
                </form>
            </div>

            <div id="edit-form-{{ current_user.username }}" class="edit-form">
                <form action="/user_edit_user/{{ current_user.username }}" method="POST">
                    <input type="text" name="name" value="{{ current_user.name }}" placeholder="Nome" required>
                    <input type="number" name="age" value="{{ current_user.age }}" placeholder="Idade" required>
                    <input type="email" name="email" value="{{ current_user.email }}" placeholder="Email" required>
                    <input type="password" name="password" placeholder="Nova Senha (opcional)">
                    <button type="submit">Salvar</button>
                </form>
            </div>

        % else:
            <h2>Houve um erro no login ou você não está autenticado.</h2>
            <a href="/portal" class="redirect-link">Faça seu login</a>
        % end

    </div>

    <script>
    function toggleEditForm(username) {
        var form = document.getElementById('edit-form-' + username);
        if (form.style.display === 'none' || form.style.display === '') {
            form.style.display = 'block'; // Exibe o formulário
        } else {
            form.style.display = 'none'; // Oculta o formulário
        }
    }
    </script>

</body>
</html>
