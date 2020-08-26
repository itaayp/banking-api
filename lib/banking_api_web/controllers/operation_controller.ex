defmodule BankingApiWeb.OperationController do
  @moduledoc """
    Esse é o Controller responsável por todas as operações bancárias (transferência e saque).
  """

  use BankingApiWeb, :controller
  alias BankingApi.Operations
  action_fallback BankingApiWeb.FallbackController

  @doc """
  Esta função é responsável por iniciar o processo de transferência bancária entre duas contas e renderizar o feedback sobre o status da operação para o usuário final.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `map`: Um map que contém:
      2.1. `"from_account" => from`: O número da conta pagadora (id da conta)
      2.2. `"to_account" => to`: O número da conta recebedora (id da conta)
      2.3. `"amount" => amount`: Valor a ser transferido
  """
  def transfer(conn, %{"from_account" => from, "to_account" => to, "amount" => amount}) do
    with {:ok, message} <- Operations.transfer(from, to, amount) do
      conn
      |> render("operation_succeeded.json", message: message)
    end
  end

  @doc """
  Esta função é responsável por iniciar a operação de saque e renderizar o feedback sobre o status do processo para o usuário final.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `map`: Um map que contém:
      2.1. `"from_account" => from`: O número da conta pagadora (id da conta)
      2.2. `"amount" => amount`: Valor a ser transferido
  """
  def withdraw(conn, %{"from_account" => from, "amount" => amount}) do
    with {:ok, message} <- Operations.withdraw(from, amount) do
      conn
      |> render("operation_succeeded.json", message: message)
    end
  end
end
