defmodule BankingApi.Accounts do
  @moduledoc """
  Este módulo representa a Accounts Context.
  Este módulo é responsável por expor as funcionalidades relacionadas à `acounts` e `users`.
  Resumidamente, o objetivo do context é desacoplar a responsabilidade de models e controllers.
  """

  alias BankingApi.Repo
  alias BankingApi.Accounts.{User, Account}

  @doc """
    Função responsável por criar um `user`(usuário) e uma `account`(conta bancária) e a associação entre eles no banco de dados
    O argumento `params` são os dados do `user` a serem inseridos.
    O retorno da função é uma tupla de `{:ok, user, account}` ou `{:error, changeset}`
  """
  def create_user(params) do
    transaction =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:user, insert_user(params))
      |> Ecto.Multi.insert(:account, fn %{user: user} ->
        user
        # Faz a associação entre o usuário e a tabela `accounts`
        |> Ecto.build_assoc(:accounts)
        # Valida e converte os dados para serem inseridos no Banco de dados
        |> Account.changeset()
      end)
      |> Repo.transaction()

    case transaction do
      {:ok, result} -> {:ok, result.user, result.account}
      {:error, :user, changeset, _tail} -> {:error, changeset}
    end
  end

  @doc """
    Função responsável por preparar um usuário para a inserção no banco de dados.
    O argumento `params` são os dados do `user` a serem preparados.
  """
  defp insert_user(params) do
    %User{}
    |> User.changeset(params)
  end

  @doc """
  Esta função busca o `user` pelo `id`, vincula o resultado com a informação da conta bancária `account`.
  O argumento da função é o `user id`.
  O retorno da função é um map do usuário vinculado com a respectiva conta bancária.
  """
  def get_user!(id), do: Repo.get(User, id) |> Repo.preload(:accounts)

  @doc """
  Esta função buscar uma `account` baseada em um `id` passado por parâmetro.
  O único parâmetro desta função é o `account id`.
  O retorno desta função é uma struct de `account`.
  """
  def get!(id), do: Repo.get(Account, id)
end
