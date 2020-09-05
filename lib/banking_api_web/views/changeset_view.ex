defmodule BankingApiWeb.ChangesetView do
  @moduledoc """
  Módulo responsável por tratar mensagens de erro e exibir ao usuário final.
  """

  use BankingApiWeb, :view

  @doc """
  Trata as mensagens de erro passadas através do argumento `changeset`.

  O argumento da função é um `changeset`
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @doc """
  Exibe ao usuário final a mensagem de erro.

  Os argumentos da função são:
    1. A string `"error.json"`
    2. Um map que contenha o `changeset` a ser manipulado

    O retorno da função um json que contenha a mensagem de erro
  """
  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
