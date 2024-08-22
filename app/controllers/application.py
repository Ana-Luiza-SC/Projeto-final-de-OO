from bottle import template,request
from app.controllers.datarecord import DataRecord

class Application():

    def __init__(self):
        # Mapeia os nomes das páginas para os métodos correspondentes
        self.pages = {
    'pagina': self.pagina,
    'portal': self.portal,
    'inicio': self.inicio,
    'blog':self.blog,
    'cadastro':self.cadastro
}
         # Instancia o modelo DataRecord, que gerencia usuários e sessões
        self.__model = DataRecord()


    def render(self,page,parameter = None):
         # Obtém o método de renderização da página baseado no nome fornecido
        content = self.pages.get(page, self.helper)
        # Renderiza a página com ou sem parâmetros
        if not parameter:
            return content()
        else:
            return content(parameter)
        

    def get_session_id(self):
        # Obtém o cookie de sessão armazenado no navegador do usuário
        return request.get_cookie('session_id')


    def helper(self):
        return template('app/views/html/helper')


    def portal(self):
        return template('app/views/html/portal')
    
    def pagina(self,username=None):
            session_id = self.get_session_id()
            username = self.__model.getUserName(session_id)
            if username is None:
                return template('app/views/html/pagina', \
                transfered=False)
            elif self.is_authenticated(username):
                session_id= self.get_session_id()
                # Obtém o usuário atual a partir do session_id
                user = self.__model.getCurrentUser(session_id)
                return template('app/views/html/pagina', \
                transfered=True, current_user=user)
            else:
                return template('app/views/html/pagina', \
                transfered=False)
        
    
    def is_authenticated(self,username):
         # Verifica se o username corresponde ao username associado ao session_id
        session_id = self.get_session_id()
        current_username = self.__model.getUserName(session_id)
        return username == current_username
    
    def authenticate_user(self,username, password):
         # Autentica o usuário verificando username e password e retornando o session_id se for válido
        session_id = self.__model.checkUser(username,password)
        if session_id:
            # Se o usuário já estiver logado, efetua logout antes de continuar
            self.logout_user()
            self.current_username = self.__model.getUserName(session_id)
            return session_id,username
        return None  
    
    def logout_user(self):
        # Limpa o username atual e efetua o logout no modelo
        self.current_username = None
        session_id = self.get_session_id()
        if session_id:
            self.__model.logout(session_id)
            
    def inicio(self):
        return template('app/views/html/inicio')
    
    def blog(self,username=None):
            session_id = self.get_session_id()
            username = self.__model.getUserName(session_id)
            if username is None:
                return template('app/views/html/blog', \
                transfered=False)
            elif self.is_authenticated(username):
                return template('app/views/html/blog', \
                transfered=True)
            else:
                return template('app/views/html/blog', \
                transfered=False)
                
    def cadastro(self):
        print('2')
        return template('app/views/html/cadastro') ## deveria ir pro arquivo cadastro.tpl

    def action_book(self, username, password, name, age, email): ##deveria criar o usuario pela função datarecord
        print('4')
        self.__model.book(username, password, name, age, email)


    