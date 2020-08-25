defmodule BankingApiWeb.FallbackController do
  use BankingApiWeb, :controller
  @moduledoc """
  O objetivo deste módulo é centralizar a manipulação de erros relacionadas ao `BankingApiWeb.UserController`.
  """

  @doc """
  A função `call` é responsável por retornar uma mensagem de erro ao usuário final quando há algum problema na criação de `user` ou `account`.
  Os argumentos da função são as informações de `connection` e os dados de `error`.
  """
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
