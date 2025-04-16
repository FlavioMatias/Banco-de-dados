# Como Rodar PostgreSQL com Docker Compose

## Arquivo `docker-compose.yml` básico

```yaml
services:
  postgres:
    image: postgres:15-alpine          # Imagem oficial do PostgreSQL (versão 15 Alpine)
    container_name: my_postgres       # Nome do container (opcional, mas útil para referência)
    environment:
      POSTGRES_USER: myuser           # Usuário padrão do banco (criado automaticamente)
      POSTGRES_PASSWORD: mypassword   # Senha padrão do usuário (NUNCA use a padrão em produção)
      POSTGRES_DB: mydatabase         # Banco de dados inicial (criado automaticamente)
    volumes:
      - postgres_data:/var/lib/postgresql/data  # Volume para persistência dos dados
    ports:
      - "5432:5432"                  # Porta host:container (5432 é a padrão do PostgreSQL)
    healthcheck:                     # Verifica se o PostgreSQL está pronto para conexões
      test: ["CMD-SHELL", "pg_isready -U myuser -d mydatabase"]  # Comando de verificação
      interval: 5s                   # Verifica a cada 5 segundos
      timeout: 5s                    # Tempo máximo de espera
      retries: 5                     # Número de tentativas antes de considerar "unhealthy"

volumes:
  postgres_data:                     # Define um volume gerenciado pelo Docker
```

## Como executar

1. Crie um diretório para o projeto:
   ```bash
   mkdir postgres-docker && cd postgres-docker
   ```

2. Crie o arquivo `docker-compose.yml` com o conteúdo acima

3. Execute o container:
   ```bash
   docker compose up -d
   ```
   *Obs: Versões mais recentes do Docker usam `docker compose` (com espaço) em vez de `docker-compose` (com hífen)*

## Comandos essenciais

| Comando | Descrição |
|---------|-----------|
| `docker compose up -d` | Inicia os containers em segundo plano |
| `docker compose down` | Para e remove os containers (mantém volumes) |
| `docker compose down -v` | Para e remove containers e volumes |
| `docker compose ps` | Lista containers em execução |
| `docker compose logs -f postgres` | Mostra logs do serviço PostgreSQL |

## Como conectar ao banco de dados

1. Acesse o terminal interativo do PostgreSQL:
   ```bash
   docker exec -it my_postgres psql -U myuser -d mydatabase
   ```

2. Para executar comandos SQL diretamente:
   ```bash
   docker exec my_postgres psql -U myuser -d mydatabase -c "CREATE TABLE teste(id SERIAL PRIMARY KEY);"
   ```

## Dicas importantes

1. **Persistência de dados**:
   - Os dados são mantidos mesmo se remover o container
   - Padrão (volume Docker):  
     ```yaml
     volumes:
       - postgres_data:/var/lib/postgresql/data
     ```
     *Localização: `docker volume inspect postgres_data`*

   - Alternativa (dados no projeto):  
     ```yaml
     volumes:
       - ./postgres_data:/var/lib/postgresql/data
     ```
     *Cria uma pasta visível no seu diretório*

2. **Segurança**:
   - Nunca use credenciais simples em produção
   - Considere usar variáveis de ambiente externas

3. **Backup**:
   ```bash
   docker exec my_postgres pg_dump -U myuser -d mydatabase > backup.sql
   ```