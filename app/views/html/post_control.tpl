% from route import sanitize_string
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Controle de Posts</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f3e5f5;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #6c3483; /* Cor da barra superior */
            color: white;
            height: 50px; /* Altura da barra superior */
            display: flex;
            align-items: center;
            font-family: 'Oswald', sans-serif;
            padding: 0 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Sombra para destaque */
        }

        .navbar_table {
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
            background-color: #4a235a; 
        }

        .content {
            padding-top: 70px; /* Ajusta o espaçamento para a barra de navegação */
            text-align: center;
        }

        .content h1 {
            color: #4a235a;
            font-size: 24px;
            margin-bottom: 20px;
            font-family: 'Oswald', sans-serif;
        }

        .content h2 {
            color: #4a235a;
            font-size: 22px;
            margin-bottom: 10px;
            font-family: 'Oswald', sans-serif;
        }

        .table_posts {
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
    <script>
        function toggleEditForm(title) {
            const form = document.getElementById(`edit-form-${title}`);
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block"; // Exibe o formulário
            } else {
                form.style.display = "none"; // Oculta o formulário
            }
        }
    </script>
</head>
<body>
    <div class="navbar">
        <table class="navbar_table">
            <tr>
                <td><h1>Controle de Posts</h1></td>
                <td style="text-align:right;">
                    % if transfered:
                        <a href="/blog">Área do Blog</a>
                        <a href="/pagina">Área do usuário</a>
                        % if current_user is not None and current_user.type == "adm":
                            <a href="/area_adm">Área do administrador</a>
                            <a href="/post">Criar Post</a>
                        %end
                    % end
                </td>
            </tr>
        </table>
    </div>

    <div class="content">
                % if not transfered:
            <h2>Houve erro no login do usuário</h2>
            <a href="/portal">Faça seu login</a>
        
        % elif current_user.type != "adm":
            <h2>Você não tem acesso a esta página, volte para:</h2>
            <a href="/pagina">Área do usuário</a>
            <a href="/blog">Área dos Blogs</a>
        % else:
            <h2>Gerenciar Posts</h2>
            <table class="table_posts">
                <tr>
                    <th>Título</th>
                    <th>Conteúdo</th>
                    <th>Autor</th>
                    <th>Data</th>
                    <th>Ações</th>
                </tr>
                % for post in current_post:
                    <tr>
                        <td>{{ post['titulo'] }}</td>
                        <td>{{ post['conteudo'] }}</td>
                        <td>{{ post['autor']['name'] }}</td>
                        <td>{{ post['data'] }}</td>
                        <td>
                            <!-- Botão para exibir o formulário de edição -->
                            <button type="button" onclick="toggleEditForm('{{ sanitize_string(post['titulo']) }}')">Editar</button>
                            <div id="edit-form-{{ sanitize_string(post['titulo']) }}" class="edit-form">
                                <form action="/edit_post/{{ sanitize_string(post['titulo']) }}" method="POST">
                                <input type="text" name="titulo" value="{{ post['titulo'] }}" placeholder="Titulo" required>
                                    <input type="text" name="conteudo" value="{{ post['conteudo'] }}" placeholder="Conteudo" required>
                                    <input type="text" name="data" value="{{ post['data'] }}" placeholder="Data" required>
                                    <button type="submit">Salvar</button>
                                    </form>
                            </div>
                            <form action="/delete_post/{{ post['titulo'] }}" method="POST" style="display:inline;">
                                <button type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                % end
            </table>
        % end
    </div>
</body>
</html>
