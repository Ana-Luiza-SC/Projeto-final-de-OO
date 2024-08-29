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
            background-color: #6c3483; /* Cor da barra superior */
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
            background-color: #4a235a; 
        }

        .content {
            padding-top: 60px; 
            text-align: center;
        }

        .content h2 {
            color: #6c3483;
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
            background-color: #6c3483;
            color: white; 
            border: none; 
            border-radius: 5px; 
            font-family: 'Roboto', sans-serif; 
            font-size: 16px; 
            cursor: pointer; 
            transition: background-color 0.3s; 
        }

        .button-center button:hover {
            background-color: #4a235a;
        }

        
</style>
</head>
<body>
    <div class="navbar">
        <table>
            <tr>
                <td class="left"><h1>Área do Usuário</h1></td>
                <td class="right" align="right">
                    <a href="/novo_post">Criar Post</a>
                    <a href="/blog">Blog</a>
                </td>
            </tr>
        </table>
    </div>
</body>

    <div class="content">
        % if transfered:
            <h2>Dados do Usuário:</h2>
            <p>Username: {{current_user.username}}</p>
            <p>Password: {{current_user.password}}</p>
            <p>Password: {{current_user.name}}</p>
            <p>Password: {{current_user.age}}</p>
            <p>Password: {{current_user.email}}</p>
            <p>idade: {{current_user.age}}</p>
            <form class="button-center" action="/logout" method="post">
                <button type="submit">Sair</button>
            </form>

        % else:
            <h2>Houve um erro no login ou você não está autenticado.</h2>
            <a href="/portal">Faça seu login</a>
        % end
    </div>
</body>
</html>
