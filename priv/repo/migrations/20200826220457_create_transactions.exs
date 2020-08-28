defmodule BankingApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :value, :decimal, precision: 15, scale: 2
      add :account_from, :string
      add :account_to, :string
      add :type, :string
      add :date, :date

      timestamps()
    end
  end
end
