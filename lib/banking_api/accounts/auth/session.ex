defmodule BankingApi.Accounts.Auth.Session do
  @moduledoc """
  Modulo responsável por autenticar um usuário.
  """

  import Ecto.Query, warn: false
  alias BankingApi.Repo
  alias BankingApi.Accounts.User

  @doc """
  Função que autentica se o email e senha passaos existem no banco de dados.

  Argumentos para a função:
    1. `email`: email do usuário
    2. `senha`: senha do usuário

  O retorno da função podem ser três tipos de tupla:
    1. `{:error, :not_found}`: Caso o email não exista no banco de dados
    2. `{:ok, user}`: Onde, `user` é uma `user struct` já com as informações de `account`
    3. `{:error, :unauthorized}`
  """
  def authenticate(email, password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        {:error, :not_found}

      user ->
        if (password == user.password) do
          {:ok, user |> Repo.preload(:accounts)}
        else
          {:error, :unauthorized}
        end
    end
  end
end
