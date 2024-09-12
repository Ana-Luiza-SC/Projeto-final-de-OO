FROM python:3.12-slim

WORKDIR /bmvc

COPY requirements.txt /bmvc

# Atualize o pip e instale o Bottle
RUN pip install --upgrade pip
RUN pip install bottle
RUN pip install datetime 
RUN pip install requests  



COPY . /bmvc

# Exponha a porta que o aplicativo usa
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT /bin/bash -c "python3 route.py"