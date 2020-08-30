defmodule BankingApi.Transactions.Transaction do
  @moduledoc """
  Transaction Model.

  Este módulo é responsável por mapear e validar os valores da tabela `transaction` entre o banco de dados e o Elixir.

  A `transaction table` é o local onde são registradas as operações bancárias no banco de dados. É importante armazenar este valor, para poder gerar o relatório de transferências.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :account_from, :string
    field :account_to, :string
    field :date, :date
    field :type, :string
    field :value, :decimal

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:value, :account_from, :account_to, :type, :date])
    |> validate_required([:value, :account_from, :account_to, :type, :date])
  end
end
