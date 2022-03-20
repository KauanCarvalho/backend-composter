[![Linkedin Badge](https://img.shields.io/badge/-Kauan%20Carvalho-6633cc?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/kauan-carvalho/)](https://www.linkedin.com/in/kauan-carvalho/)
[![Linkedin Badge](https://img.shields.io/badge/-Luiz%20Henrique-6633cc?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/luiz-henrique-speht-reis-de-oliveira-1307141b6//)](https://www.linkedin.com/in/luiz-henrique-speht-reis-de-oliveira-1307141b6/)

# Backend Composter

#### Versões:

| Ruby  | Rails |  PostgreSQL |
| :---: | :---: | :---------: |
| 3.0.0 | 6.0.3 |     14.0    |

#### Clonando o repositório:

        $ git clone git@github.com:KauanCarvalho/backend-composter.git

#### Rodando a aplicação com docker-compose:

1. Copie as variáveis necessárias para o ambiente de desenvolvimento e preencha de acordo [development]:

        $ cp .env.sample .env.development

2. Suba os containers com o docker-compose:

        $ docker-compose up -d

3. Entre no container do server:

        $ docker exec -it backend_composer_server bash

4. Instale as dependências:

        $ bundle install

5. Crie o banco com as migrações:

        $ bundle exec rake db:create db:migrate

6. Rode os testes e o rubocop (linter):

        $ RAILS_ENV=test bundle exec rspec && bundle exec rubocop

7. Suba o servidor:

        $ bundle exec rails s -b 0.0.0.0

## License
[MIT](https://choosealicense.com/licenses/mit/)
