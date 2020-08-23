defmodule BankingApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
        add :email, :string
        add :first_name, :string
        add :last_name, :string
        add :password, :string
        add :role, :string
        timestamps()
    end

    # Grants that there will not be any duplicated email on the database
    create unique_index(:users, [:email])
  end
end
