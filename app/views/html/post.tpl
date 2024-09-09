<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Post</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif; /* Aplica Roboto Bold ao corpo */
            margin: 0;
            padding: 0;
            background-color: #101733;
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
            padding-top: 60px;
            text-align: center;
        }

        .content h2 {
            color: #090D1F;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group textarea {
            resize: vertical;
            height: 150px;
        }

        .form-group input[type="submit"] {
            background-color: #090D1F;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .form-group input[type="submit"]:hover {
            background-color: #273570;
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
        %if not transfered:
            <h2>Houve erro no login do usuário</h2>
            <a href="/portal">Faça seu login</a>
        
        %elif current_user.type != "adm":
            <h2>Você não tem permissão para criar posts. Volte para a <a href="/pagina">Página de Usuário</a></h2>
        
        %else:
            <div class="form-container">
                <h2>Crie um Novo Post</h2>
                <form action="/novo_post" method="POST">
                    <div class="form-group">
                        <label for="titulo">Título:</label>
                        <input type="text" id="titulo" name="Titulo" required>
                    </div>
                    <div class="form-group">
                        <label for="conteudo">Conteúdo:</label>
                        <textarea id="conteudo" name="Conteudo" required></textarea>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Publicar">
                    </div>
                </form>
            </div>
        %end
    </div>
</body>
</html>
