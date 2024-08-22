

class UserAccount():
    def __init__(self, username, password,name, age, email):
        self.username= username
        self.password= password
        self.name = age
        self.age = age
        self.email= email

class text():
    def __init__(self,autor,titulo,conteudo):
        self.autor = autor
        self.titulo = titulo
        self.conteudo = conteudo
        
        
class post(text):
        def __init__(self, autor, titulo, conteudo,data, curtidas):
             super().__init__(autor, titulo, conteudo)
             self.data = data
             self.curtidas = curtidas
             
class comentario(text):
        def __init__(self, autor, titulo, conteudo, verificado):
            super().__init__(autor, titulo, conteudo)
            self.verificado = verificado
            
