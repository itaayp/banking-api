defmodule BankingApi.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  @doc """
  A função `change` cria a tabela `accounts` no banco de dados
  O atributo `precision` define a quantidade máxima de dígitos que a colúna `balance` terá
  O atributo `scale` define a quantidade de casas decimais
  """
  def change do
    create table(:accounts) do
      add :balance, :decimal, precision: 15, scale: 2
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
