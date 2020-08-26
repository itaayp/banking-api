defmodule BankingApiWeb.OperationController do
  @moduledoc """
    Esse é o Controller responsável por todas as operações bancárias (transferência e saque).
  """

  use BankingApiWeb, :controller
  alias BankingApi.Operations
  action_fallback BankingApiWeb.FallbackController

  @doc """
  A função `transfer/2` é responsável por iniciar o processo de transferência bancária entre duas contas e renderizar o feedback sobre o resultado da transferência para o usuário final.
  Os argumentos da função são as informações da conexão: `conn` e um map contendo o id da conta que fará a operação: `from_account`, o id da conta que receberá a transferência: `to_account` e o valor transferido: `amount`
  """
  def transfer(conn, %{"from_account" => from, "to_account" => to, "amount" => amount}) do
    with {:ok, message} <- Operations.transfer(from, to, amount) do
      conn
      |> render("operation_succeeded.json", message: message)
    end
  end
end
