defmodule BankingApiWeb.OperationController do
  @moduledoc """
    Operation Controller.

    Controller responsável por iniciar qualquer operação no back-end a partir de uma requisição da API relacionada a `/api/operations`.
  """

  use BankingApiWeb, :controller
  alias BankingApi.Operations
  action_fallback BankingApiWeb.FallbackController

  @doc """
  Esta função é responsável por iniciar o processo de transferência bancária entre duas contas e renderizar o feedback sobre o status da operação para o usuário.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `%{"to_account" => to, "amount" => amount}`: Um map que contenha:
      2.1. `to_account`: O número da conta recebedora (id da conta)
      2.2. `amount`: Valor a ser transferido
  """
  def transfer(conn, %{"to_account" => to, "amount" => amount}) do
    # Busca a `user struct` do usuário que está realizando a transferência
    user = Guardian.Plug.current_resource(conn)
    amount = Decimal.new(amount)

    with false <- Operations.is_transfering_to_same_account?(user.accounts, to),
         {:ok, message} <- Operations.transfer(user.accounts, to, amount) do
      conn
      |> render("operation_succeeded.json", message: message)
    end
  end

  @doc """
  Esta função é responsável por iniciar a operação de saque e renderizar o feedback sobre o status do processo para o usuário.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `%{"amount" => amount}`: Um map que contenha:
      2.1. `amount`: Valor a ser transferido
  """
  def withdraw(conn, %{"amount" => amount}) do
    # Busca a `user struct` do usuário que está realizando a transferência
    user = Guardian.Plug.current_resource(conn)
    amount = Decimal.new(amount)

    with {:ok, message} <- Operations.withdraw(user.accounts, amount) do
      IO.puts("Placeholder: Enviando email para o usuario")
      IO.puts("Mensagem do email: Voce acabou de realizar um saque")

      conn
      |> render("operation_succeeded.json", message: message)
    end
  end
end
