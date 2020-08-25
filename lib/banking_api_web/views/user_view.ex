defmodule BankingApiWeb.UserView do
  @moduledoc """
  Essa é a User View. Esse módulo é responsável pelo layout que é apresentado ao usuário após chamar funções referentes ao User Controller
  """

  use BankingApiWeb, :view

  @doc """
  retorna um `map` contendo as informações de conta bancária.
  Os argumentos da função são a string "account.json" e um map contendo as structs de `user` e `account`
  """
  def render("account.json", %{user: user, account: account}) do
    %{
      "Informações da conta": %{
        "saldo em conta": "R$ #{account.balance},00",
        "número da conta": account.id
      },
      "Informações do usuário": %{
        "Nome completo": "#{user.first_name} #{user.last_name}",
        "Email": user.email,
        "senha cadastrada": user.password,
        "Tipo de acesso ao sistema": user.role
      }
    }
  end

  def render("show.json", %{user: user}) do
    render_one(user, BankingApiWeb.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      "Informações do usuário": %{
        "Nome completo": "#{user.first_name} #{user.last_name}",
        "Email": user.email,
        "senha cadastrada": user.password,
        "Tipo de acesso ao sistema": user.role
      },
      "Informações da conta": %{
        "saldo em conta": "R$ #{user.accounts.balance},00",
        "número da conta": user.accounts.id
      }
    }
  end
end
