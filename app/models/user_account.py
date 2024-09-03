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
    def __init__(self, autor_username, titulo, conteudo, data):
        self.autor_username = autor_username
        self.titulo = titulo
        self.conteudo = conteudo
        self.data = data

    def to_dict(self):
        return {
            "autor_username": self.autor_username,
            "titulo": self.titulo,
            "conteudo": self.conteudo,
            "data": self.data
        }