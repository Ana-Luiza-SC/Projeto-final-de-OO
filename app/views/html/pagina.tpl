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
            background-color: #5216d2; /* Cor do botão de ir para o portal */
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
            display: inline-block;
            line-height: 30px; /* Alinhamento vertical ajustado */
            font-size: 16px; /* Tamanho da fonte do botão ajustado */
        }

        .navbar a:hover {
            background-color: #6c3483; /* Cor do botão ao passar o mouse */
        }

        .content {
            padding-top: 60px; /* Para evitar que o conteúdo fique sob a navbar */
            text-align: center;
        }

        .content h2 {
            color: #6c3483;
        }

        .content p {
            font-size: 18px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <table>
            <tr>
                <td class="left"><h1>Área do Usuário</h1></td>
                <td class="right" align="right"><a href="/portal">Ir para o portal</a></td>
            </tr>
        </table>
    </div>

    <div class="content">
        % if transfered: 
            <h2>Dados do Usuário:</h2>
            <p>Username: {{current_user.username}}</p>
            <p>Password: {{current_user.password}}</p>
        % else: 
            <h2>Houve erro no login do usuário :(</h2>
        % end 
    </div>
</body>
</html>
