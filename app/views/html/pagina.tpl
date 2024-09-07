<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página do Usuário</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif; /* Aplica Roboto Bold ao corpo */
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #090D1F; /* Cor da barra superior */
            color: white;
            height: 50px; /* Altura da barra superior */
            display: flex;
            align-items: center;
            font-family: 'Oswald', sans-serif;
            padding: 0 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Sombra para destaque */
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
            font-size: 20px; /* Tamanho da fonte ajustado */
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
            display: inline-block;
            line-height: 30px; /* Alinhamento vertical ajustado */
            font-size: 16px; /* Tamanho da fonte do botão ajustado */
        }

        .navbar a:hover {
            background-color: #273570; 
        }

        .content {
            padding-top: 100px; 
            text-align: center;
        }

        .content h2 {
            color: #090D1F;
        }

        .content p {
            font-size: 18px;
            color: #666;
        }

        .button-center {
            text-align: center;
            margin-top: 20px;
        }

        /* Estiliza o botão */
        .button-center button {
            padding: 10px 20px;
            background-color: #090D1F;
            color: white; 
            border: none; 
            border-radius: 5px; 
            font-family: 'Roboto', sans-serif; 
            font-size: 16px; 
            cursor: pointer; 
            transition: background-color 0.3s; 
        }

        .button-center button:hover {
            background-color: #273570;
        }

        .table_users {
            width: 80%;
            margin: 0 auto 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #6c3483;
            color: white;
            font-family: 'Oswald', sans-serif;
        }

        td button {
            padding: 5px 10px;
            background-color: #6c3483;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: 'Roboto', sans-serif;
            transition: background-color 0.3s;
        }

        td button:hover {
            background-color: #4a235a;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        form input, form select, form button {
            width: 200px;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: 'Roboto', sans-serif;
        }

        form button {
            background-color: #6c3483;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        form button:hover {
            background-color: #4a235a;
        }

        .edit-form {
            display: none; /* Começa oculto */
        }
    </style>
</head>
<body>

    <div class="navbar">
        <table>
            <tr>
                <td class="left"><h1>Área do Usuário</h1></td>
                <td class="right" align="right">
                    <a href="/blog">Blog</a>
                    % if current_user is not None and current_user.type == "adm":
                        <a href="/area_adm">Área do administrador</a>
                        <a href="/post">Criar Post</a>
                        <a href="/post_adm">Controle dos Posts</a>
                    %end
                </td>
            </tr>
        </table>
    </div>

    <div class="content">
        % if transfered:
            <h2>Dados do Usuário:</h2>
            <p>Username: {{current_user.username}}</p>
            <p>Nome: {{current_user.name}}</p>
            <p>Idade: {{current_user.age}}</p>
            <p>Email: {{current_user.email}}</p>
            <form class="button-center" action="/logout" method="post">
                <button type="submit">Sair</button>
            </form>

            <h2>Gerenciar Usuário</h2>
            <table class="table_users">
                        <!-- Botão para exibir o formulário de edição -->
                        <button type="button" onclick="toggleEditForm('{{ current_user.username }}')">Editar</button>

                    <!-- Formulário de edição -->
                    <div id="edit-form-{{ current_user.username }}" class="edit-form">
                        <form class="button-center" action="/user_edit_user/{{ current_user.username }}" method="POST">
                            <input type="text" name="name" value="{{ current_user.name }}" placeholder="Nome" required>
                            <input type="number" name="age" value="{{ current_user.age }}" placeholder="Idade" required>
                            <input type="email" name="email" value="{{ current_user.email }}" placeholder="Email" required>
                            <input type="password" name="password" placeholder="Nova Senha (opcional)">
                            <button type="submit">Salvar</button>
                        </form>
                    </div>


                        <!-- Formulário de exclusão -->
                        <form class="button-center" action="/user_delete_user/{{ current_user.username }}" method="POST" style="display:inline;">
                            <button type="submit">Excluir</button>
                        </form>

                    </td>
                </tr>
            </table>

        % else:
            <h2>Houve um erro no login ou você não está autenticado.</h2>
            <a href="/portal">Faça seu login</a>
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
