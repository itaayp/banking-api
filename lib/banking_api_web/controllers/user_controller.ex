defmodule BankingApiWeb.UserController do
  @moduledoc """
  User Controller.

  Controller responsável por iniciar qualquer operação no back-end a partir de uma requisição da API relacionada a `/api/auth` ou `/api/user`.
  """

  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  alias Accounts.Auth.Guardian

  action_fallback BankingApiWeb.FallbackController

  @doc """
  Cadastra um novo usuário no sistema e criar uma nova conta bancária para este usuário.

  Os argumentos da função são:
    1. `conn`: as informações de conexão
    2. `%{"user" => user}`: Um map que contenha:
      * `user`: A `user struct` a ser criada no sistema
  """
  def signup(conn, %{"user" => user}) do
    with {:ok, user, account} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      # Adiciona no `header` da response o atributo `location` com o path para `BankingApiWeb.UserController.show()`, da rout `GET /api/user`
      |> put_resp_header("location", Routes.user_path(conn, :show, id: user.id))
      |> render("account.json", %{user: user, account: account})
    end
  end

  @doc """
  Autentica um usuário no sistema e renderizar o feedback de signin para o usuário final

  Os argumentos da função são:
    1. `conn`: as informações de conexão
    2. `%{"email" => email, "password" => password}`: Um map que contenha:
      * `email`: O email do usuário
      * `password`: A senha do usuário
  """
  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user_auth.json", user: user, token: token)
    end
  end

  @doc """
  Busca um usuário pelo `id` e renderizar as informações deste usuário obtido.

  Os argumentos da função são:
    1. `conn`: as informações de conexão
    2. `%{"id" => id}`: Um map que contenha:
      * `id`: O email do usuário
  """
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    conn
    |> render("show.json", user: user)
  end
end
