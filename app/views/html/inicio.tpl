<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página Inicial</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
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

        .content {
            padding-top: 60px; /* Para evitar que o conteúdo fique sob a navbar */
            text-align: center;
            margin-top: 100px;
        }

        .content h1 {
            color: #003366;
            font-size: 36px;
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
                <td><h2>Página Princial</h2></td>
                <td style="text-align: right;">
                <a href="/portal">Login</a>
                <a href="/cadastro">Cadastro</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="content">
        <h1>Bem-vindo à Página Inicial</h1>
        <p>Clique em "Login" no canto superior direito para acessar sua conta.</p>
    </div>
</body>
</html>
