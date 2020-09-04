defmodule BankingApiWeb.ChangesetView do
  @moduledoc """
  Módulo responsável por tratar mensagens de erro e exibir ao usuário final.
  """

  use BankingApiWeb, :view

  @doc """
  Trata as mensagens de erro passadas através do argumento `changeset`.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @doc """
  Exibe ao usuário final a mensagem de erro.
  """
  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
