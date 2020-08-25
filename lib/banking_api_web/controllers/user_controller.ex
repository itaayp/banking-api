defmodule BankingApiWeb.UserController do
  @moduledoc """
  Esse é o Controller do User. Este módulo resonsável por manipular as ações relacionadas ao usuário
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
      |> render("account.json", %{user: user, account: account})
    end
  end
end
