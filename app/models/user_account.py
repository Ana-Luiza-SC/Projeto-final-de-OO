

class UserAccount():
    def __init__(self, username, password,age):
        self.username= username
        self.password= password
        self.age = age

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
            
