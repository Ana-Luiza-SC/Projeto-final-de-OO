class UserAccount():
    def __init__(self, username, password,name, age, email,type):
        self.username= username
        self.password= password
        self.name = name
        self.age = age
        self.email= email
        self.type = type

class text():
    def __init__(self,autor,titulo,conteudo):
        self.autor = autor
        self.titulo = titulo
        self.conteudo = conteudo
          
class post(text): #herança
        def __init__(self, autor, titulo, conteudo, data):
             super().__init__(autor, titulo, conteudo)
             self.data = data
             
class comentario(text):
        def __init__(self, autor, titulo, conteudo, verificado):
            super().__init__(autor, titulo, conteudo)
            self.verificado = verificado
            

