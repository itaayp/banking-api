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
  O retorno da função é a resposta ao usuário final que pode ser: uma mensagem informativa, caso o insert tenha dado certo, ou uma mensagem de erro, caso por algum motivo não tenha sido feito o insert.
  """
  def signup(conn, %{"user" => user}) do
    with {:ok, user, account} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      |> render("account.json", %{user: user, account: account})
    end
  end
end
