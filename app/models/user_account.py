import json
from datetime import datetime

class UserAccount:
    def __init__(self, username, password, name, age, email, type):
        self.username = username
        self.password = password
        self.name = name
        self.age = age
        self.email = email
        self.type = type

    def to_dict(self):
        return {
            "username": self.username,
            "password": self.password,
            "name": self.name,
            "age": self.age,
            "email": self.email,
            "type": self.type
        }

class post:
    def __init__(self, autor: UserAccount, titulo, conteudo, data):
        self.autor = {
            "username": autor.username,
            "password": autor.password,
            "name": autor.name,
            "age": autor.age,
            "email": autor.email,
            "type": autor.type
        }
        self.titulo = titulo
        self.conteudo = conteudo
        self.data = data

    @classmethod
    def from_dict(cls, data):
        autor_data = data['autor']
        autor = UserAccount(
            autor_data['username'],
            autor_data['password'],
            autor_data['name'],
            autor_data['age'],
            autor_data['email'],
            autor_data['type']
        )
        return cls(autor, data['titulo'], data['conteudo'], data['data'])

    def to_dict(self):
        return {
            "autor": self.autor,
            "titulo": self.titulo,
            "conteudo": self.conteudo,
            "data": self.data
        }
