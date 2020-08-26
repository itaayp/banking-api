defmodule BankingApiWeb.UserController do
  @moduledoc """
  Esse é o User Controller. Este módulo é o primeiro contato entre as requisições e o back-end
  """

  use BankingApiWeb, :controller
  alias BankingApi.Accounts

  action_fallback BankingApiWeb.FallbackController

  @doc """
  A função `signup` é responsável por cadastrar um novo usuário no sistema e criar uma nova conta bancária para este usuário.
  O argumento `user` da função são os dados do novo usuário que será inserido no sistema.
  O retorno da função é a resposta ao usuário final que pode ser: uma mensagem informativa, caso o retorno de `create_user` tenha retornado `{:ok, user, account}`, ou uma mensagem de erro, caso o retorno de `create_user` tenha sido outro.
  Neste segundo caso, o Plug `BankingApiWeb.FallbackController.call()` é invocado, e lá e construida o feedback de erro para o usuário.
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
  Esta função é responsável por buscar um usuário pelo `id` e renderizar as informações deste usuário obtido.
  Os argumentos da função são as informações de conexão `conn` e o `id` do usuário que será resgatado
  """
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    conn
    |> render("show.json", user: user)
  end
end
