from bottle import template,request
from app.controllers.datarecord import DataRecord

class Application():

    def __init__(self):
        # Mapeia os nomes das páginas para os métodos correspondentes
        self.pages = {
    'pagina': self.pagina,
    'portal': self.portal,
    'inicio': self.inicio,
    'blog':self.blog
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
        self._current_username = None
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
    
    

"""
O sistema de login do seu projeto funciona utilizando sessões baseadas em cookies. Quando um usuário faz login, o sistema verifica as 
credenciais (nome de usuário e senha) e, se forem válidas, gera um session_id único, que é armazenado como um cookie no navegador do usuário. 
Esse session_id é usado para identificar o usuário em solicitações futuras e para mostrar informações personalizadas, como o nome de usuário 
na página.

Se as informações não aparecem em outro navegador, isso ocorre porque os cookies (incluindo o session_id) são específicos para cada navegador.
Quando você abre um novo navegador, ele não possui o cookie com o session_id do usuário autenticado no primeiro navegador, então o sistema não 
reconhece que esse usuário já está logado, e as informações personalizadas não são exibidas. Para acessar as informações em outro navegador, 
o usuário precisaria fazer login novamente.
"""