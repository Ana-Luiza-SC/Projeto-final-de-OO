from app.models.user_account import UserAccount, text, post, comentario
import json
import uuid 

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
            with open("app/controllers/db/user_accounts.json", "r") as arquivo_json:
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
        with open("app/controllers/db/user_accounts.json", "w") as arquivo_json:
            user_data = [vars(user_account) for user_account in \
            self.__user_accounts]
            json.dump(user_data, arquivo_json, indent=4)

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
                user.password = new_data.get('password', user.password)
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
        # Salva os usuários de volta no arquivo JSON
        with open("app/controllers/db/user_accounts.json", "w") as arquivo_json:
            user_data = [vars(user_account) for user_account in self.__user_accounts]
            json.dump(user_data, arquivo_json, indent=4)
    
class Post:
    def __init__(self):
        # Lista para armazenar os posts
        self.posts_Blog = []
        self.get_posts()

    def criar_post(self, autor, titulo, conteudo, data):
        posts_existentes = self.get_posts()
        new_post = post(autor, titulo, conteudo, data)
        
        # Adiciona o novo post à lista existente de posts
        posts_existentes.append(vars(new_post))  # Converte o post para um dicionário
        
        # Escreve a lista atualizada de posts de volta para o arquivo JSON
        with open("app/controllers/db/posts-blog.json", "w",encoding="utf-8") as arquivo_json:
            json.dump(posts_existentes, arquivo_json, indent=4, ensure_ascii=False)
            
            
    def read(self):
        try:
            with open("app/controllers/db/posts-blog.json", "r",encoding='utf-8') as arquivo_json:
                post_data = json.load(arquivo_json)
                self.posts_Blog = [Post(**data) for data in post_data]
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
        """Edita um post existente com base no título."""
        #posts_existentes = self.get_posts()
        
        for post_data in self.posts_Blog:
            if post_data.titulo == titulo:
                post_data.autor = novos_dados.get('autor', post_data.autor) # Atualiza os dados do post
                post_data.conteudo = novos_dados.get('conteudo', post_data.conteudo)
                post_data.data = novos_dados.get('data', post_data.data)
                break
        self.save_posts()
                
        
        return False  # Retorna False se o post com o título especificado não for encontrado

    def delete_post(self, titulo):
        """Remove um post existente com base no título."""
        self.posts_Blog = [post for post in self.posts_Blog if post.titulo != titulo]
        self.save_posts()
        # Filtra os posts, mantendo apenas aqueles que não correspondem ao título especificado
        #posts_restantes = [post_data for post_data in posts_existentes if post_data['titulo'] != titulo]


    def save_posts(self):
        # Salva os post de volta pro arquivo json
        with open("app/controllers/db/posts-blog.json", "w") as arquivo_json:
            post_data = [vars(posts_Blog) for posts_Blog in self.posts_Blog]
            json.dump(post_data, arquivo_json, indent=4)