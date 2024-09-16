<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog</title>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&family=Roboto:wght@700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #090D1F;
        }

        .top {
            color: #FFF;
            font-family: Inter;
            font-size: 70px;
            font-style: normal;
            font-weight: 700;
            line-height: normal;
            text-align: center; /* Centraliza o texto dentro do contêiner */
            max-width: 100%; /* Remove a largura fixa */
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
            background-color: #273570;
        }

        .content {
            padding-top: 100px; /* Adiciona espaçamento suficiente para que o conteúdo não fique oculto */
            text-align: center;
        }

        .content h2 {
            color: #FFFFFF;
            font-size: 24px;
            margin-bottom: 10px;
            font-family: 'Oswald', sans-serif;
            text-align: center; 
        }

        .content h3 {
            color: #FFFFFF;
            font-size: 20px;
            margin-bottom: 10px;
            font-family: 'Oswald', sans-serif;
            text-align: center; 
        }

        /* Estilização para o conteúdo dos posts */
        .content p {
            font-size: 18px;
            color: #C0C5D0;
            line-height: 1.6;
            margin-bottom: 20px;
            text-align: center; 
        }
        
        
        .content .button-center {
            display: flex; /* Usa flexbox para centralizar o botão */
            justify-content: center; /* Centraliza horizontalmente */
            margin: 20px 0; /* Espaçamento vertical */
        }

        /* Estilização para o link de criação de novos posts */
        .content a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #090D1F;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-family: 'Roboto', sans-serif;
            font-size: 16px;
            margin: 20px auto;
            text-align: center; 
        }

        .content a:hover {
            background-color: #4a235a;
        }

        .post-container {
            background-color: #0e132b;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 800px; /* Define uma largura máxima para a caixa */
            margin-left: auto;
            margin-right: auto;
            border: none;
        }

        .post-container h3 {
            color: white; /* Cor do título dentro da caixa */
            font-family: 'Oswald', sans-serif;
        }

        .post-container p {
            color: #dcdde1; /* Cor do texto dentro da caixa */
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

        /* Centralizar conteúdo não transferido */
        .not-transferred-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color = white;
        }
        .not-transferred-container h2 {
        color: #FFFFFF; /* Cor branca para o texto do h2 */
    }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <table>
            <tr>
                <td class="right" align="right">
                    %if transfered:
                        <a href="/pagina">Área do usuário</a>
                    %end
                    % if current_user is not None and current_user.type == "adm":
                        <a href="/area_adm">Área do administrador</a>
                        <a href="/post">Criar Post</a>
                        <a href="/post_adm">Controle dos Posts</a>
                    %end
                </td>
            </tr>
        </table>
    </div>

     % if transfered == True:

    <!-- Título principal -->
    <div class="top">
        <h2>Guia de estudos</h2>
                    % if current_user.type == "adm":
                <h4>Você é um administrador</h4>
            % end
    </div>

    <div class="content"> 
        <article>
            % for post in current_post:
                <div class="post-container">
                    <h3>{{ post['titulo'] }}</h3>  <!-- Acessando a chave 'titulo' de um dicionário -->
                    <p>{{ post['conteudo'] }}</p>
                    <p>Autor: {{ post['autor']['name'] }}</p>
                    <p>Data: {{ post['data'] }}</p>
                </div>
            % end
        </article>
    </div>
    
    % else:
    <div class="not-transferred-container">
        <h2>Houve erro no login do usuário</h2>
        <a href="/portal" class="redirect-link">Faça seu login</a>
    </div>
    % end

</body>
</html>
