<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Área de Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: 'Roboto', sans-serif; /* Aplica Roboto Bold ao corpo */
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #6c3483; /* Cor da barra superior */
            color: white;
            height: 50px; /* Altura ajustada da barra superior */
            display: flex;
            align-items: center;
            font-family: 'Oswald', sans-serif;
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
            font-size: 20px; /* Tamanho da fonte ajustado */
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px; /* Padding ajustado */
            border-radius: 5px;
            transition: background-color 0.3s;
            display: inline-block;
            line-height: 30px; /* Alinhamento vertical ajustado */
            font-size: 16px; /* Tamanho da fonte do botão ajustado */
        }

        .navbar a:hover {
            background-color: #4a235a; /* Cor do botão ao passar o mouse */
        }


        .login-container {
            background-color: white;
            border: 1px solid black;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin: 100px auto;
            max-width: 500px;
        }

        .login-container h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #6c3483; /* Cor do título "Login" */
            font-family: 'Oswald', sans-serif; /* Aplica Oswald Medium ao título "Login" */
        }

        .login-container label {
            display: block;
            margin-bottom: 8px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #6c3483; /* Cor do botão de login */
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-family: 'Oswald', sans-serif; /* Aplica Oswald Medium ao botão de login */
        }

        .login-container input[type="submit"]:hover {
            background-color: #5b2d77; /* Cor ao passar o mouse no botão */
        }
    </style>
</head>
<body>
    <div class="navbar">
        <table>
            <tr>
                <td class="left"><h2>Sistema de Login</h2></td>
                <td class="right" align="right"><a href="/inicio" style="color: white; text-decoration: none; font-family: 'Oswald', sans-serif;">Início</a></td>
            </tr>
        </table>
    </div>

    <div class="login-container">
        <h1>Login</h1>
        <form action="/portal" method="post">
            <label for="username">Nome:</label> 
            <input id="username" name="username" type="text" required />

            <label for="password">Senha:</label>
            <input id="password" name="password" type="password" required />

            <input value="Login" type="submit" />
        </form>
    </div>
</body>
</html>
