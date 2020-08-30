defmodule BankingApiWeb.FallbackController do
  @moduledoc """
  O objetivo deste módulo é centralizar a manipulação de erros relacionadas às Controllers da aplicação.
  """

  use BankingApiWeb, :controller

  @doc """
  Renderiza a mensagem de erro ao usuário final.

  Os argumentos da função são:
    1. `conn`: as informações de `connection` e da `request`.
    2. Uma tupla que contenha o atom `:error` e a `changeset`.
  """
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  @doc """
  Renderiza a mensagem de erro ao usuário final.

  Os argumentos da função são:
    1. `conn`: as informações de `connection` e da `request`.
    2. Uma tupla que contenha o atom `:error` e a mensagem a ser exibida ao usuário.
  """
  def call(conn, {:error, message}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingApiWeb.ErrorView)
    |> render("error_message.json", message: message)
  end
end
