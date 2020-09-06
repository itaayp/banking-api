# BankingApi
* Este projeto faz parte do processo seletivo de recrutamento da Stone. [`Veja as especificações`](https://gist.github.com/Isabelarrodrigues/15e62f07eebf4e076b93897a64d9c674)

## Breve descrição do projeto

Desenvolver, em Elixir, uma API para bancos onde fosse possível:
 1. Criar novos usuários e novas contas bancárias
 2. Realizar transferência
 3. Realizar saque
 4. Emitir relatório de operações bancárias realizadas por dia, mês, ano e total
 5. Garantir a autenticação do usuário antes de realizar operações bancárias
 6. Garantir acesso aos relatórios somente para usuários administradores

# Documentação
## Documentação de uso da aplicação (Documentação da API)
[`Clique aqui`](https://documenter.getpostman.com/view/3587450/TVCfW8eJ) para encontrar a documentação da API

## Documentação do código (Documentação de módulo)

[`Clique aqui`](https://banking-api-documentation.herokuapp.com/) para encontrar a documentação do código

## Documentação de setup
Siga os passos a seguir para rodar a aplicação localmente:
 1. Instale a versão `1.10.3` do Elixir e a versão `21.0` do Erlang. [`Leia a documentação`](https://elixir-lang.org/install.html)
 2. Abra o seu terminal preferido. Nós vamos precisar para os próximos passos.
 3. Execute o comando `mix local.hex` para instalar o `hex`
 4. Execute o comando `mix archive.install hex phx_new 1.5.4` para instalar a versão `1.5.4` do Phoenix
 5. Instale a versão `v10.16.3` do Node. [`Leia a documentação`](https://nodejs.org/en/download/)
 6. Instale o Postgres. [`Leia a documentação`](https://wiki.postgresql.org/wiki/Detailed_installation_guides)

## Documentação de deploy
### Pré-requisitos:
 1. Instale **python3**
 2. Instale **pip3**. [Leia a documentação](https://packaging.python.org/tutorials/installing-packages/) para mais informações
 3. Instale **git**. [Leia a documentação](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) para mais informações
 4. Crie uma conta no [Gigalixir](https://www.gigalixir.com/)
 5. Instale **Gigalixir cli**.
   
    5.1. Para isso, abra o seu terminal e rode o comando abaixo. (Obs: Após rodar o comando, mantenha o seu terminal aberto. Vamos precisar dele para as próximas etapas)
    ```
    pip3 install gigalixir --user
    ``` 
 6. Faça um clone do projeto [`stone-banking-api`](https://github.com/itaayp/stone-banking-api) em sua máquina.
  ```
  git clone https://github.com/itaayp/stone-banking-api.git
  ```
 7. Pelo terminal, acesse o diretório do projeto e inicie o git: 
  ```
  cd stone-banking-api
  git init
  ```
 8. Adicione a track do repositório remoto:
  ```
  git remote add gigalixir https://itay.profissional%40gmail.com:31ce1eb2-b95e-47e6-9063-805c9b86cc89@git.gigalixir.com/stone-banking-api-itay.git
  ```
 

### Passo-a-passo para o deploy:
 1. Faça as alterações no código.
 2. Acesse o diretório onde está a aplicação 
 ```
 cd <APPLICATION_PATH>
 ```
 3. Faça o commit das alterações:
 ```
 git add .
 git commit -m "I'm learning how to deploy"
 ```
 4. Faça login no Gigalixir
 ```
 gigalixir login
 ```
 5. Faça o deploy!
 ```
 git push gigalixir master
 ```


# Frameworks e conceitos do ecossistema Elixir utilizados durante o desenvolvimento
 1. Phoenix Framework
 2. Credo - Para a análise, refatoração e legibilidade de código
 3. Guardian - Para a autenticação de usuários na API
 4. Exdoc - Para criar a [`documentação de código`](https://banking-api-documentation.herokuapp.com/)


# Links extras


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
