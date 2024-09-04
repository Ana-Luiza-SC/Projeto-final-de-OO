from app.models.user_account import UserAccount, post
import json
import uuid 
import os
import tempfile

class DataRecord:
    """Banco de dados JSON para o recurso Usuários"""

    def __init__(self):
        # Lista para armazenar contas de usuários
        self.__user_accounts = []
        # Dicionário para armazenar usuários autenticados e suas sessões
        self.__authenticated_users = {}
        # Chama o método read para carregar os dados do arquivo JSON
        self.read()

    def read(self):
        try:
            # Tenta abrir e ler o arquivo JSON que contém as contas de usuários
            with open("app/controllers/db/user_accounts.json", "r", encoding='utf-8') as arquivo_json:
                user_data = json.load(arquivo_json)
                # Converte os dados do JSON em objetos UserAccount
                self.__user_accounts = [UserAccount(**data) for data in user_data]
        except FileNotFoundError:
            # Se o arquivo não for encontrado, cria uma conta Guest padrão
            self.__user_accounts.append(UserAccount('Guest', '010101', '101010'))

    def book(self,username,password,name,age,email,type):
        # Cria uma nova conta de usuário e a adiciona à lista, importante pro trabalho
        new_user= UserAccount(username,password,name,age,email,type)
        self.__user_accounts.append(new_user)
        # Escreve a lista atualizada de usuários de volta no arquivo JSON
        with open("app/controllers/db/user_accounts.json", "w", encoding='utf-8') as arquivo_json:
            user_data = [vars(user_account) for user_account in \
            self.__user_accounts]
            json.dump(user_data, arquivo_json, indent=4, ensure_ascii=False)

    def getCurrentUser(self, session_id):
        # Retorna o usuário associado ao session_id, se existir
        return self.__authenticated_users.get(session_id, None)

    def getUserName(self, session_id):
        # Retorna o nome de usuário associado ao session_id, se existir
        user = self.getCurrentUser(session_id)
        return user.username if user else None

    def getUserSessionId(self, username):
        for session_id, user in self.__authenticated_users.items():
            if username == user.username:
                return session_id
        return None

    def checkUser(self, username, password):
        # Verifica se as credenciais são válidas
        for user in self.__user_accounts:
            if user.username == username and user.password == password:
                # Se as credenciais são válidas, gera um novo session_id
                session_id = str(uuid.uuid4())  # Gera um ID de sessão único
                # Associa o session_id ao usuário
                self.__authenticated_users[session_id] = user
                return session_id  # Retorna o ID de sessão para o usuário
        return None

    def logout(self, session_id):
        # Remove o usuário autenticado com base no session_id
        if session_id in self.__authenticated_users:
            del self.__authenticated_users[session_id]  # Remove o usuário logado
            
    def get_all_users(self):
        # Retorna uma lista de todos os usuários
        return self.__user_accounts

    def update_user(self, username, new_data):
        # Atualiza os dados de um usuário existente
        for user in self.__user_accounts:
            if user.username == username:
                # Atualiza a senha somente se uma nova senha for fornecida
                if 'password' in new_data and new_data['password']:
                    user.password = new_data['password']
                # Atualiza os demais dados
                user.name = new_data.get('name', user.name)
                user.age = new_data.get('age', user.age)
                user.email = new_data.get('email', user.email)
                user.type = new_data.get('type', user.type)
                break
        self.save_users()


    def delete_user(self, username):
        # Remove um usuário da lista
        self.__user_accounts = [user for user in self.__user_accounts if user.username != username]
        self.save_users()

    def save_users(self):
        # Caminho para o arquivo original
        file_path = "app/controllers/db/user_accounts.json"
        # Cria um arquivo temporário
        with tempfile.NamedTemporaryFile('w', delete=False, dir=os.path.dirname(file_path), encoding='utf-8') as tmpfile:
            json.dump([vars(user_account) for user_account in self.__user_accounts], tmpfile, indent=4, ensure_ascii=False)
            tempname = tmpfile.name
        # Substitui o arquivo original pelo temporário
        os.replace(tempname, file_path)

    
class Post:
    def __init__(self):
        self.posts_Blog = []
        self.get_posts()
        self.read()

    def criar_post(self, autor: UserAccount, titulo, conteudo, data):
        new_post = post(autor,titulo,conteudo, data)
        
        self.posts_Blog.append(new_post)
        self.save_posts()


            
    def read(self):
        try:
            with open("app/controllers/db/posts-blog.json", "r", encoding='utf-8') as arquivo_json:
                post_data = json.load(arquivo_json)
                self.posts_Blog = [post.from_dict(data) for data in post_data]
        except FileNotFoundError:
            self.posts_Blog = []


    def get_posts(self):
        """Lê os posts do arquivo JSON e retorna uma lista de dicionários."""
        try:
            with open("app/controllers/db/posts-blog.json", "r", encoding='utf-8') as file:
                data = json.load(file)
                return data  # Retorna a lista de posts
        except FileNotFoundError:
            print("Erro: O arquivo posts-blog.json não foi encontrado.")
            return []
        except json.JSONDecodeError:
            print("Erro: O arquivo JSON está mal formatado.")
            return []

        
    def edit_post(self, titulo, novos_dados):
        titulo_modificado = titulo.replace("_", " ")
        
        for post_data in self.posts_Blog:
            print(post_data.titulo == titulo_modificado)
            if post_data.titulo == titulo_modificado:
                post_data.conteudo = novos_dados.get('conteudo', post_data.conteudo)
                post_data.data = novos_dados.get('data', post_data.data)
                break
        self.save_posts()
        return False  # Retorna False se o post com o título especificado não for encontrado
    
    def delete_post(self, titulo):
        """Remove um post existente com base no título."""
        print(f"Título para deletar: {titulo}")
        print(f"Títulos existentes: {[post.titulo for post in self.posts_Blog]}")
        self.posts_Blog = [post for post in self.posts_Blog if post.titulo != titulo]
        self.save_posts()


    def save_posts(self):
        try:
            with open("app/controllers/db/posts-blog.json", "w", encoding='utf-8') as file:
                json.dump([post.to_dict() for post in self.posts_Blog], file, indent=4, ensure_ascii=False)
        except IOError as e:
            print(f"Erro ao salvar posts: {e}")
