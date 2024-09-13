FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

# Atualize o pip e instale o Bottle
RUN pip install --no-cache-dir -r requirements.txt



COPY . .

# Exponha a porta que o aplicativo usa
EXPOSE 8080

# Comando para executar a aplicação
#ENTRYPOINT /bin/bash -c "python3 route.py"
ENTRYPOINT ["python3","route.py"]