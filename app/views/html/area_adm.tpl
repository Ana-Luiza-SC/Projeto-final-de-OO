    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Painel de Administração</title>
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
        background-color: #090D1F;
        color: white;
        height: 50px;
        display: flex;
        align-items: center;
        font-family: 'Oswald', sans-serif;
        padding: 0 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        z-index: 1000; /* Adiciona o z-index para sobreposição */
    }

            .navbar_table {
                width: 100%;
                border-collapse: collapse;
            }

            .navbar td {
        vertical-align: middle;
        padding: 0 20px;
        border: none; /* Remova a borda */
        color: white; /* Garante que o texto esteja branco */
    }

            .navbar h1 {
        margin: 0;
        font-size: 20px; /* Tamanho da fonte ajustado */
        color: white; /* Garante que o texto esteja branco */
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
                padding-top: 70px; /* Ajusta o padding-top para garantir que o conteúdo não fique oculto */
                text-align: center;
            }

            .content h1 {
                color: #FFFFFF;
                font-size: 24px;
                margin-bottom: 20px;
                font-family: 'Oswald', sans-serif;
            }

            .content h2 {
                color: #FFFFFF;
                font-size: 22px;
                margin-bottom: 10px;
                font-family: 'Oswald', sans-serif;
            }

            .table_users {
        width: 80%;
        margin: 0 auto 20px auto;
        border-collapse: collapse;
        background-color: #f9f9f9; /* Fundo mais claro para a tabela */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
        color: #333; /* Tom de cinza mais forte para o texto */
    }

    th {
        background-color: #090D1F;
        color: white;
        font-family: 'Oswald', sans-serif;
    }


            td button {
        padding: 5px 10px;
        background-color: #090D1F;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-family: 'Roboto', sans-serif;
        transition: background-color 0.3s;
        margin-right: 5px; /* Espaçamento entre os botões */
    }

    td form {
        display: inline; /* Garante que o formulário de exclusão fique lado a lado com o botão de editar */
    }

    td button:hover {
        background-color: #273570;
    }

    td .edit-form button {
        margin-top: 10px;
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
                background-color: #090D1F;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            form button:hover {
                background-color: #273570;
            }

            .edit-form {
                display: none; /* Começa oculto */
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
                color: #ffffff; /* Cor do texto do link */
                text-decoration: none;
                padding: 10px 20px;
                background-color: #090D1F; /* Fundo do link */
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
            <table class="navbar_table">
                <tr>
                    <td><h1 color = white>Área do Administrador</h1></td>
                    
                    <td style="text-align:right;">
                        %if transfered:
                            <a href="/blog">Blog</a>
                            <a href="/pagina">Área do usuário</a>

                            % if current_user.type == "adm":
                                <a href="/post">Criar post</a>
                                <a href="/post_adm">Controle dos Posts</a>
                            %   end
                        %end
                    </td>
                </tr>
            </table>
        </div>

        <div class="content">
            %if not transfered:
                <h2>Houve erro no login do usuário</h2>
                <a href="/portal" class="redirect-link">Faça seu login</a>
            
            % elif current_user.type != "adm":
                <h2>Você não tem acesso à essa página, volte para as seguintes páginas</h2>
                <a href="/pagina" class="redirect-link">Área do usuário</a>
                <a href="/blog" class="redirect-link">Área dos Blogs</a>

            %else:
                <h2>Gerenciar Usuários</h2>
                <table class="table_users">
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
                                <!-- Botão para exibir o formulário de edição -->
                                <button type="button" onclick="toggleEditForm('{{ user.username }}')">Editar</button>

                                <!-- Formulário de edição -->
                                <div id="edit-form-{{ user.username }}" class="edit-form">
                                    <form action="/edit_user/{{ user.username }}" method="POST">
                                        <input type="text" name="name" value="{{ user.name }}" placeholder="Nome" required>
                                        <input type="text" name="password" value="{{ user.password }}" placeholder="Senha" required>
                                        <input type="number" name="age" value="{{ user.age }}" placeholder="Idade" required>
                                        <input type="email" name="email" value="{{ user.email }}" placeholder="Email" required>
                                        <select name="type" required>
                                            <option value="user" {% if user.type == 'user' %} selected {% endif %}>User</option>
                                            <option value="adm" {% if user.type == 'adm' %} selected {% endif %}>Admin</option>
                                        </select>
                                        <button type="submit">Salvar</button>
                                    </form>
                                </div>

                                <!-- Formulário de exclusão -->
                                <form action="/delete_user/{{ user.username }}" method="POST" style="display:inline;">
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
                        <option value="adm">Admin</option>
                    </select>
                    <button type="submit">Adicionar</button>
                </form>
            %end
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
