# Etapa 1: Escolha uma imagem base oficial do Python.
# A versão 'slim' é uma boa escolha para produção, pois é menor que a padrão.
# O README menciona Python 3.10+, então vamos usar uma versão estável como a 3.11.
FROM python:3.11-slim

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker reutilizará a camada de instalação das dependências, acelerando os builds.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# Usar --no-cache-dir para reduzir o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Comando para executar a aplicação com Uvicorn.
# Usamos "0.0.0.0" para que o servidor seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
