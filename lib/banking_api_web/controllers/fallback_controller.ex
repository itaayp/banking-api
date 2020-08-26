defmodule BankingApiWeb.FallbackController do
  @moduledoc """
  O objetivo deste módulo é centralizar a manipulação de erros relacionadas ao `BankingApiWeb.UserController`.
  """

  use BankingApiWeb, :controller

  @doc """
  A função `call` é responsável por retornar uma mensagem de erro ao usuário final quando há algum problema na criação de `user` ou `account`.
  Os argumentos da função são as informações de connection `conn` e os dados de `error`.
  """
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  @doc """
  A função `call` é responsável por retornar uma mensagem de erro ao usuário final quando há algum problema durante alguma operation, seja ela de `transfer` ou de `withdraw`.
  Os argumentos da função são as informações de connection `conn` e a mensagem de erro: `message`.
  """
  def call(conn, {:error, message}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingApiWeb.ErrorView)
    |> render("error_message.json", message: message)
  end
end
