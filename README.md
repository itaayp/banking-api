# BankingApi
* Este projeto faz parte do processo seletivo de recrutamento da Stone. [`Especificações do projeto`](https://gist.github.com/Isabelarrodrigues/15e62f07eebf4e076b93897a64d9c674)

## Breve descrição do projeto

Desenvolver em Elixir uma API para bancos onde fosse possível:
 1. Criar novos usuários e novas contas bancárias
 2. Realizar transferência
 3. Realizar saque
 4. Emitir relatório de operações bancárias realizadas por dia, mês, ano e total
 5. Garantir a autenticação do usuário antes de realizar operações bancárias
 6. Garantir acesso aos relatórios somente para usuários administradores

# Documentação
## Documentação de uso da aplicação (Documentação da API)

## Documentação do código (Documentação de módulo)

[`Clique aqui`](https://banking-api-documentation.herokuapp.com/) para encontrar a documentação do código

## Documentação de setup

## Documentação de deploy

### Pré-requisitos:
 1. Instale **python3**
 2. Instale **pip3**. [Leia a documentação](https://packaging.python.org/tutorials/installing-packages/) para mais informações
 3. Instale **git**. [Leia a documentação](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) para mais informações
 4. Crie uma conta no [`Gigalixir`](https://www.gigalixir.com/)
 5. Instale **Gigalixir cli**. Para isso, abra o seu terminal e rode o comando `pip3 install gigalixir --user`. (Obs: mantenha o terminal aberto para as próximas etapas) 
 6. Faça um clone do projeto [`stone-banking-api`](https://github.com/itaayp/stone-banking-api) em sua máquina.
 7. Acesse a pasta através do comando `cd <APPLICATION_PATH>` e inicie um projeto git na pasta: `git init`
 
 ```
 git clone https://github.com/itaayp/stone-banking-api.git
 ```

### Passo-a-passo para deploy:
 1. Acesse a pasta onde está a aplicação 
```
cd application_path
```
 2. Faça login no Gigalixir
  ```
   gigalixir login
  ```
 3. Adicione a track do repositório remoto:
  ```
  git remote add gigalixir https://itay.profissional%40gmail.com:31ce1eb2-b95e-47e6-9063-805c9b86cc89@git.gigalixir.com/stone-banking-api-itay.git
  ```
4. Faça as alterações no código.
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
