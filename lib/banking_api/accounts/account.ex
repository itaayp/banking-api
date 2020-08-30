defmodule BankingApi.Accounts.Account do
  @moduledoc """
  Account Model.

  Este módulo é responsável por mapear e validar os valores da tabela `accounts` entre o banco de dados e o Elixir.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :balance, :decimal, precision: 15, scale: 2, default: 1000
    belongs_to :user, BankingApi.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(account, attrs \\ %{balance: 1000}) do
    account
    |> cast(attrs, [:balance])
    |> validate_required([:balance])
  end
end
