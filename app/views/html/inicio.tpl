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
            background: #090D1F;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #090D1F; /* Cor da barra superior */
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
            background-color: #273570; /* Cor do botão ao passar o mouse */
        }

        .content {
            padding-top: 60px; /* Para evitar que o conteúdo fique sob a navbar */
            text-align: center;
            margin-top: 100px;
        }

        .content h1 {
            color: #FFF;
            font-family: Inter;
            font-size: 90px;
            font-style: normal;
            font-weight: 700;
            line-height: normal;
        }

        .content p {
            font-size: 18px;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <table>
            <tr>
                <td><h2>Página Inicial</h2></td>
                
                <td style="text-align: right;">
                <a href="/portal">Login</a>
                <a href="/cadastro">Cadastre-se</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="content">
        <h1>Bem-vindo(a) à Página Inicial do</h1>
        <h1>Guia de estudos</h1>
        <p>Clique em "Login" no canto superior direito para acessar sua conta.</p>
    </div>
</body>
</html>
