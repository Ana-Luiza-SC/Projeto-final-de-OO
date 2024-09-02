from bottle import template, request, redirect
from app.controllers.datarecord import DataRecord, Post 

class Application():

    def __init__(self):
        # Mapeia os nomes das páginas para os métodos correspondentes
        self.pages = {
    'pagina': self.pagina,
    'portal': self.portal,
    'inicio': self.inicio,
    'blog':self.blog,
    'cadastro': self.cadastro,
    'post':self.post,
    'area_adm':self.administrador,
    'post_control': self.post_control
}
         # Instancia o modelo DataRecord, que gerencia usuários e sessões
        self.__model = DataRecord()
        self.__posts = Post()

#---------------paginas iniciais e controles-----------------------------------------------

    def render(self,page,parameter = None):
        content = self.pages.get(page, self.helper)
        if not parameter:
            return content()
        else:
            return content(parameter)
        
    def get_session_id(self):
        return request.get_cookie('session_id')

    def helper(self):
        return template('app/views/html/helper')

    def portal(self):
        return template('app/views/html/portal')
    
        
    def is_authenticated(self,username):
         # Verifica se o username corresponde ao username associado ao session_id
        session_id = self.get_session_id()
        current_username = self.__model.getUserName(session_id)
        return username == current_username
    
    def authenticate_user(self,username, password):
         # Autentica o usuário verificando username e password e retornando o session_id se for válido
        session_id = self.__model.checkUser(username,password)
        if session_id:
            self.logout_user()
            self.current_username = self.__model.getUserName(session_id)
            return session_id,username
        return None  
    
    def logout_user(self):
        # Limpa o username atual e efetua o logout no modelo
        self._current_username = None
        session_id = self.get_session_id()
        if session_id:
            self.__model.logout(session_id)
            
    def inicio(self):
        return template('app/views/html/inicio')
    
    def cadastro(self):
        return template('app/views/html/cadastro')

    def action_book(self, username, password, name, age, email):
        self.__model.book(username, password, name, age, email, type = "user")
        
        
# ------------------------------- páginas dos usuários ------------------------------------------
    
    def blog(self,username=None):
            session_id = self.get_session_id()
            username = self.__model.getUserName(session_id)
            if username is None:
                return template('app/views/html/blog', \
                transfered=False, current_user = None)
            elif self.is_authenticated(username):
                post = self.__posts.get_posts() #manda os post disponíveis
                session_id= self.get_session_id() #manda o usuário atual
                user = self.__model.getCurrentUser(session_id)
                return template('app/views/html/blog', \
                transfered=True, current_post = post, current_user = user)
            else:
                return template('app/views/html/blog', \
                transfered=False, current_user = None)
                
    def pagina(self,username=None):
            session_id = self.get_session_id()
            username = self.__model.getUserName(session_id)
            if username is None:
                return template('app/views/html/pagina', \
                transfered=False, current_user = None)
            elif self.is_authenticated(username):
                session_id= self.get_session_id()
                # Obtém o usuário atual a partir do session_id
                user = self.__model.getCurrentUser(session_id)
                return template('app/views/html/pagina', \
                transfered=True, current_user=user)
            else:
                return template('app/views/html/pagina', \
                transfered=False,current_user = None)
    
    
    
#------------------------página de controle dos post --------------------------------------------------


    def post(self): #páginas de novos posts
        session_id = self.get_session_id()
        username = self.__model.getUserName(session_id) #verificar se está logado
        if username is None:
            return template('app/views/html/post', \
            transfered=False, current_user = None)
        elif self.is_authenticated(username):
            session_id= self.get_session_id() #manda o usuário atual
            user = self.__model.getCurrentUser(session_id)
            return template('app/views/html/post', \
            transfered=True, current_user = user)
        else:
            return template('app/views/html/post', \
                transfered=False, current_user = None)
    
    def action_post(self,autor, titulo, conteudo, data): # guarda o novo post
        self.__posts.criar_post(autor, titulo, conteudo, data)
        
    def post_control(self): #página responsável para a remoção e edição dos post
        session_id = self.get_session_id()
        username = self.__model.getUserName(session_id)
        
        if username is None:   
            return template('app/views/html/post_control', transfered=False, current_user=None)
        
        elif self.is_authenticated(username):
            user = self.__model.getCurrentUser(session_id)
            post = self.__posts.get_posts()
            return template('app/views/html/post_control', transfered=True, current_user=user, current_post=post)
        
        else:
            return template('app/views/html/post_control', transfered=False, current_user=None)

    def edit_post(self, title, new_data):  # Atualiza o post pelo título
        # Verifica se o usuário logado é administrador
        session_id = self.get_session_id()
        current_user = self.__model.getCurrentUser(session_id)
        posts = self.__posts.get_posts()
        if current_user and current_user.type == "adm":
            for post in posts:
                if post['titulo'] == title:
                    self.__posts.edit_post(title, new_data)
                    break
            return redirect('/post_adm')

    def delete_post(self, title):  # Remove o post
        self.__posts.delete_post(title)
        return redirect('/post_adm')

        
#---------------------- página de controle de usuários ----------------------------------------------

    def administrador(self):
        session_id = self.get_session_id()
        username = self.__model.getUserName(session_id)  # verificar se está logado
        if username is None:
            return template('app/views/html/area_adm', \
            transfered=False, current_user=None)
        elif self.is_authenticated(username):
            session_id = self.get_session_id()
            current_user = self.__model.getCurrentUser(session_id)
            users = self.__model.get_all_users()
            return template('app/views/html/area_adm', \
            transfered=True, current_user=current_user, users=users)
        else:
            return template('app/views/html/area_adm', \
                transfered=False, current_user=None)


    def add_user(self, username, password, name, age, email, type):
        # Verifica se o usuário logado é administrador
        session_id = self.get_session_id()
        current_user = self.__model.getCurrentUser(session_id)

        if current_user and current_user.type == "adm":
            self.__model.book(username, password, name, age, email, type)
            return redirect('/area_adm')
        else:
            return "Acesso negado. Somente administradores podem adicionar usuários."

    def edit_user(self, username, new_data):
        # Verifica se o usuário logado é administrador
        session_id = self.get_session_id()
        current_user = self.__model.getCurrentUser(session_id)

        if current_user and current_user.type == "adm":
            self.__model.update_user(username, new_data)
            return redirect('/area_adm')
        else:
            return "Acesso negado. Somente administradores podem editar usuários."

    def delete_user(self, username):
        # Verifica se o usuário logado é administrador
        session_id = self.get_session_id()
        current_user = self.__model.getCurrentUser(session_id)

        if current_user and current_user.type == "adm":
            self.__model.delete_user(username)
            return redirect('/area_adm')
        else:
            return "Acesso negado. Somente administradores podem excluir usuários."