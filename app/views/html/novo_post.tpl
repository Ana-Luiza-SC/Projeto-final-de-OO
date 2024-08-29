<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Post</title>
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

        .navbar h2 {
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
            padding-top: 60px;
            text-align: center;
        }

        .content h2 {
            color: #6c3483;
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
            background-color: #6c3483;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .form-group input[type="submit"]:hover {
            background-color: #4a235a;
        }

        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <table>
            <tr>
                <td><h2>criação de novos posts</h2></td>
                <td style="text-align: right;">
                    <a href="/blog">Blog</a>
                    <a href="/pagina">Página de Usuário</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="content">
        <div class="form-container">
            <h2>Crie um novo post</h2>
            <form action="/novo_post" method="POST">
                <label for="autor">Autor:</label>
                <input type="text" id="autor" name="Autor">
                
                <label for="titulo">Título:</label>
                <input type="text" id="titulo" name="Titulo">
                
                <label for="conteudo">Conteúdo:</label>
                <textarea id="conteudo" name="Conteudo"></textarea>
                
                <input type="submit" value="Publicar">
            </form>

        </div>
    </div>
</body>
</html>
