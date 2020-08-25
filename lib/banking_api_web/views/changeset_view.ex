defmodule BankingApiWeb.ChangesetView do
  @moduledoc """
  Este módulo é responsável por tratar mensagens de erro e exibir para o usuário final.
  Os erros tratados são relacionados a criação de `user` e `account`.
  """

  use BankingApiWeb, :view

  @doc """
  Esta função é responsável por resgatar e tratar mensagens de erro passadas através do argumento `changeset`
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @doc """
  A função `render` é responsável por exibir para o usuário final a mensagem de erro relacionada a criação de `user` e de `account`
  """
  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
