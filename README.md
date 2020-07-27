## Sobre
- API para sistema de coleta em campo
- Organização e estruturação dos dados coletados.
- Saída em json para um servidor externo.
- PostgreSQL, para o banco de dados
- Deploy no Heroku
- Link da API (https://coleta-em-campo-api.herokuapp.com)
- Link da documentação da API (https://coleta-em-campo-api.herokuapp.com/apipie)

## Instalação

- $ git clone https://github.com/myllenaalves/coleta-em-campo-API.git
- $ cd coleta-em-campo-API/
- $ bundle install
- $ bundle exec rails server

Obs: É importante verificar a criação das databases locais (database.yml)

## Aplicação em funcionamento

- Para executar os testes:
  - $ RAILS_ENV=test rake db:reset
  - $ RAILS_ENV=test rake db:migrate
  - $ bundle exec rspec

- Para executar o servidor:
  - $ bundle exec rails server
  
  ## Autenticação

 - Para realizar a autenticação do usuário é necessário inserir o token sobre a chave Authorization no Header de qualquer requisição
  que precise de autenticação.
