defmodule BankingApi.Accounts.Account do
  @moduledoc """
  Essa é a Account Model. Este módulo é responsável por mapear os valores do banco de dados com o Elixir e validá-los.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  Essa é a referência no código Elixir para a tabela `accounts` no banco de dados.
  """
  schema "accounts" do
    field :balance, :decimal, precision: 15, scale: 2, default: 1000
    belongs_to :user, BankingApi.Accounts.User
    timestamps()
  end

  @doc """
  Essa função converte a informação para o formato do Elixir e às valida.
  Os parâmetros da função são a `account struct` que será usada para identificar a tabela no banco de dados, e o `params`, que são os dados que serão inseridos no BD
  """
  def changeset(account, attrs \\ %{balance: 1000}) do
    account
    |> cast(attrs, [:balance])
    |> validate_required([:balance])
  end
end
