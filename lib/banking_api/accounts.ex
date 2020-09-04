defmodule BankingApi.Accounts do
  @moduledoc """
  Accounts Context.

  Este módulo é responsável por expor as funcionalidades relacionadas à `acounts` e `users`.

  Resumidamente, o objetivo do context é desacoplar a responsabilidade de models e controllers.
  """

  alias BankingApi.Repo
  alias BankingApi.Accounts.{User, Account}

  @doc """
  Cria um `user`, uma `account`(conta bancária) e faz a associação entre ambos no banco de dados

  O argumento da função é:
    1. `params`: Um map com as chaves de `user struct` a serem inseridos.

  Há dois possíveis retornos para a função:
    1. Uma tupla do tipo: `{:ok, user, account}`, onde `user` e `account` são structs
    2. Uma tupla do tipo: `{:error, changeset}`

  ## Examples
      iex> user = %{
        email: "email@email.com",
        first_name: "first_name",
        last_name: "last_name",
        password: "pwd",
        password_confirmation: "pwd"
      }
      iex> Accounts.create_user(user)
      %{:ok, %User{...}, %Account{...}}
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

  defp insert_user(params) do
    %User{}
    |> User.changeset(params)
  end

  @doc """
  Busca o `user` no banco de dados e vincula o resultado com a respectiva conta bancária.

  Argumentos da função:
    1. `id`: O `id` do usuário em formato Integet

  O retorno da função é uma `user struct` carregada com a respectiva `account struct`.

  ## Examples
      iex> Accounts.get_user!(10)
      %User{accounts: %Account{...}, ...}
  """
  def get_user!(id), do: Repo.get(User, id) |> Repo.preload(:accounts)

  @doc """
  Busca por uma `account`.

  O argumento desta função é:
    1. `id`: O `id` da `account` em formato Integer

  O retorno desta função é uma struct de `account`.

  ## Examples
      iex> Accounts.get!(10)
      %Account{...}
  """
  def get!(id), do: Repo.get(Account, id)
end
