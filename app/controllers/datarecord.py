
from app.models.user_account import UserAccount
import json
import uuid


class DataRecord():
##Banco de dados JSON para o recurso Usuários

    def __init__(self):
        # Lista para armazenar contas de usuários
        self.__user_accounts= []
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
            self.__user_accounts.append(UserAccount('Guest', '010101','101010'))


    def book(self,username,password, name, age, email):
        # Cria uma nova conta de usuário e a adiciona à lista, importante pro trabalho
        new_user = UserAccount(username, password, name, age, email)
        self.__user_accounts.append(new_user)
        # Escreve a lista atualizada de usuários de volta no arquivo JSON
        with open("app/controllers/db/user_accounts.json", "w") as arquivo_json:
            user_data = [vars(user_account) for user_account in \
            self.__user_accounts]
            json.dump(user_data, arquivo_json)


    def getCurrentUser(self,session_id):
        # Retorna o usuário associado ao session_id, se existir
        if session_id in self.__authenticated_users:
            return self.__authenticated_users[session_id]
        else:
            return None


    def getUserName(self,session_id):
        # Retorna o nome de usuário associado ao session_id, se existir
        if session_id in self.__authenticated_users:
            return self.__authenticated_users[session_id].username
        else:
            return None # Retorna None se o usuário não for encontrado


    def getUserSessionId(self, username):
        for session_id in self.__authenticated_users:
            if username == self.__authenticated_users[session_id].username:
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
            del self.__authenticated_users[session_id] # Remove o usuário logado