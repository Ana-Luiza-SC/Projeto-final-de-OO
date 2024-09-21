# Blog: Guia de Estudos

Este projeto é um sistema de gerenciamento de usuários e posts, desenvolvido em Python com o framework Bottle. Ele permite que administradores gerenciem usuários e posts em um blog, incluindo funcionalidades como cadastro e edição de contas de usuários, controle de autenticação e acesso restrito a páginas administrativas.

## Índice

- [Descrição do Projeto](#descrição-do-projeto)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Funcionalidades](#funcionalidades)
- [Como Executar o Projeto](#como-executar-o-projeto)


## Descrição do Projeto

Este projeto é um sistema de gerenciamento de usuários e posts, desenvolvido em Python com o framework Bottle. O sistema permite que administradores gerenciem usuários e posts em um blog. As funcionalidades incluem:

- **Cadastro e Edição de Usuários:** Administradores podem adicionar, editar e excluir usuários, definindo tipos de usuários como "user" ou "adm". Os usuários também podem criar, editar e excluir suas próprias contas.

- **Criação e Gerenciamento de Posts:** Os administradores podem criar novos posts, editá-los e excluí-los. Cada post contém um título e conteúdo.

- **Controle de Autenticação:** O sistema possui um sistema de autenticação, garantindo que apenas usuários registrados possam acessar certas funcionalidades.

- **Acesso Restrito:** Somente usuários do tipo adm têm acesso às páginas administrativas, garantindo a segurança e a integridade do sistema.

- **Interface de Usuário:** O projeto possui uma interface web intuitiva, com navegação facilitada entre diferentes áreas, como painel do administrador e área do usuário.

## Tecnologias Utilizadas

- Python (Flask)
- HTML
- CSS
- JavaScript

## Funcionalidades

- Gerenciamento de usuários (adicionar, editar, excluir)
- Criação e edição de posts
- Sistema de login e cadastro
- Área do usuário e área do administrador

## Como Executar o Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/Ana-Luiza-SC/Projeto-final-de-OO
   ```

2. Execute o aplicativo:
    ```bash
    python route.py
    ```
3. Acesse o projeto em seu navegador através do endereço:

    ```bash
    http://localhost:8000
    ```
