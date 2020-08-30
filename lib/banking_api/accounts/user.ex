defmodule BankingApi.Accounts.User do
  @moduledoc """
  Esse é o User Model. Este módulo é responsável por mapear os valores do banco de dados com o Elixir e validá-los.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"
    timestamps()

    has_one :accounts, BankingApi.Accounts.Account
  end

  @doc false
  def changeset(user, params) do
    user
    |> cast(params, [
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :role
    ])
    |> validate_required([
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :role
    ])
    |> update_change(:email, &String.downcase(&1))
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]+$/,
      message: "Email em formato invalido."
    )
    |> validate_confirmation(:password,
      message: "A confirmacao de senha nao esta igual a senha digitada."
    )
    |> unique_constraint(:email, message: "Este email ja foi usado em outro cadastro.")
  end
end
