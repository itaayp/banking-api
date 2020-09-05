defmodule BankingApiWeb.TransactionView do
  @moduledoc """
  Transaction View.

  Esse módulo é responsável por renderizar ao usuário final os reports de transações por data
  """

  use BankingApiWeb, :view

  @doc """
  Renderiza o relatório de transações.

  Os argumentos da função são:
    1. A string `show.json`.
    2. `%{transaction: transaction}`: Um map que contenha
      * `transaction`: Uma lista com `transaction structs` e o valor total operado
  """
  def render("show.json", %{transaction: transaction}) do
    render_one(transaction, BankingApiWeb.TransactionView, "report.json")
  end

  @doc """
  Monta o relatório de transações e renderiza o relatório ao usuário final.

  Os argumentos da função são:
    1. A string `report.json`.
    2. `%{transaction: transaction}`: Um map que contém a lista de transações a ser exibida e o total operado.
  """
  def render("report.json", %{transaction: transaction}) do
    transaction_list =
      Enum.map(transaction.transactions, fn transaction ->
        %{
          "Data da operação": transaction.date,
          "Conta de origem": transaction.account_from,
          "Conta de destino": transaction.account_to,
          "Tipo de operação": transaction.type,
          "Quantia operada": "R$ #{transaction.value}"
        }
      end)

    %{"Total operado": "R$ #{transaction.total}", Operações: transaction_list}
  end
end
