defmodule BankingApiWeb.UserView do
  @moduledoc """
  User View.

  Módulo responsável por renderizar ao usuário final o feedback sobre as requisições requisições da API relacionadas a `/api/auth` e `/api/user`.
  """

  use BankingApiWeb, :view

  @doc """
  Renderiza as informações de um usuário.

  Os argumentos da função são:
    1. A string `"user.json"`
    2. `%{user: user}`: Um map que contenha a `user struct`
  """
  def render("user.json", %{user: user}) do
    %{
      "Informações do usuário": %{
        "Nome completo": "#{user.first_name} #{user.last_name}",
        Email: user.email,
        "senha cadastrada": user.password,
        "Tipo de acesso": user.role
      },
      "Informações da conta": %{
        "saldo em conta": "R$ #{user.accounts.balance}",
        "número da conta": user.accounts.id
      }
    }
  end

  @doc """
  Renderiza as informações de uma conta bancária.

  Os argumentos da função são:
    1. A string "account.json"
    2. `%{user: user, account: account`: map que contenha:
      2.1. `user`: Uma `user struct`
      2.2. `account`: Uma `account struct`
  """
  def render("account.json", %{user: user, account: account}) do
    %{
      "Informações da conta": %{
        "saldo em conta": "R$ #{account.balance}",
        "número da conta": account.id
      },
      "Informações do usuário": %{
        "Nome completo": "#{user.first_name} #{user.last_name}",
        Email: user.email,
        "senha cadastrada": user.password,
        "Tipo de acesso": user.role
      }
    }
  end

  @doc """
  Renderiza somente um `user`.

  Os argumentos da função são:
    1. A string `show.json`
    2. `%{user: user}`: Um map que contenha uma `user struct`.
  """
  def render("show.json", %{user: user}) do
    render_one(user, BankingApiWeb.UserView, "user.json")
  end

  @doc """
  Renderiza o feedback de signin quando o usuário é autenticado com sucesso no sistema.

  Os argumentos da função são:
    1. A string `"user_auth.json"`
    2. Um map que contenha as propriedades:
      2.1. `user`: Uma `user struct`
      2.2. `token`: Uma string com o valor `token` gerado pelo framework de autenticação, Guardian
  """
  def render("user_auth.json", %{user: user, token: token}) do
    user = Map.put(render_one(user, BankingApiWeb.UserView, "user.json"), :token, token)
    %{data: user}
  end
end
