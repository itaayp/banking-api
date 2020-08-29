defmodule BankingApi.Operations do
  @moduledoc """
  Este é o Operations Context.

  Este módulo é responsável por expor as funcionalidades relacionadas às operações de `transfer` e `withdraw`.

  Resumidamente, o objetivo de um context é desacoplar a responsabilidade de models e controllers.
  """

  alias BankingApi.{Accounts, Accounts.Account}
  alias BankingApi.Repo
  alias BankingApi.Transactions.Transaction
  alias Ecto.Multi

  # variáveis de módulo
  @withdraw "withdraw"
  @transfer "transfer"

  @doc """
  Esta função é responsável por operar a transferência bancária entre duas contas.

  Os argumentos desta função são:
    1. `from`: É a `account struct` da conta pagadora.
    2. `to_id`: O número da conta recebedora (id da conta).
    3. `amount`: Quantidade a ser transferida.

  O retorno da função é um map contendo o atom `:error` ou `:ok`. Representando o status da operação.

  Um dos possíveis motivos da operação não ser realizada (e retornar um  `error`), é se o valor `amount` a ser transferido é maior do que `from.balance`.
  """
  def transfer(from, to_id, amount) do
    operate_if_not_negative(from.balance, amount, transfer_operation(from, to_id, amount))
  end

  @doc """
  Esta função é responsável por operar a operação de saque.

  Os argumentos desta função são:
    1. `from`: É a `account struct` de onde será feito saque.
    2. `amount`: Quantidade a ser transferida.

  O retorno da função é um map contendo o atom `:error` ou `:ok`. Representando o status da operação.

  Um dos possíveis motivos da operação não ser realizada, é se o valor `amount` é maior do que `from.balance`.
  """
  def withdraw(from, amount) do
    operate_if_not_negative(from.balance, amount, withdraw_operation(from, amount))
  end

  defp withdraw_operation(from, amount) do
    Multi.new()
    |> Multi.update(:account_from, perform_operation(from, amount, :sub))
    |> Multi.insert(
      :transaction,
      create_transaction_struct(amount, Integer.to_string(from.id), "~", @withdraw)
    )
    |> Repo.transaction()
    |> handle_feedback("Saque realizado! Foram sacados R$ #{amount} da conta #{from.id}")
  end

  defp operate_if_not_negative(balance, amount, function) do
    case is_negative?(balance, amount) do
      true ->
        {:error,
         "O saldo de sua conta não permite fazer uma transferência de R$ #{amount},00. Você não pode fazer transferências maiores que R$ #{
           balance
         },00"}

      false ->
        function
    end
  end

  defp is_negative?(balance, amount) do
    Decimal.sub(balance, amount)
    |> Decimal.negative?()
  end

  @doc """
  Esta função é responsável por realizar a subtração no saldo da conta pagadora, e realizar a operação de soma no saldo da conta recebedora da transferência.

  Os argumentos da função são:
    1. `from`: É uma struct de `account` e representa a conta pagadora.
    2. `to_id`: É o id da conta recebedora.
    3. `amount`: Quantidade a ser transferida
  """
  def transfer_operation(from, to_id, amount) do
    to = Accounts.get!(to_id)

    Multi.new()
    |> Multi.update(:from, perform_operation(from, amount, :sub))
    |> Multi.update(:to, perform_operation(to, amount, :sum))
    |> Multi.insert(
      :transaction,
      create_transaction_struct(amount, Integer.to_string(from.id), to_id, @transfer)
    )
    |> Repo.transaction()
    |> handle_feedback(
      "Transferência concluída! Transferência realizada da conta #{from.id} para a conta #{to.id} no valor de #{
        amount
      }"
    )
  end

  defp handle_feedback(operations, message) do
    case operations do
      {:ok, _tail} ->
        {:ok, message}

      {:error, :from, changeset, _tail} ->
        {:error, changeset}

      {:error, :to, changeset, _tail} ->
        {:error, changeset}

      {:error, :transaction, changeset, _tail} ->
        {:error, changeset}
    end
  end

  @doc """
  A função perform_operation/3 que recebe como último parâmetro o atom `:sub` é responsável por realizar a operação de subtração na `account` passada por parâmetro.
  Os argumentos da função são uma struct `account`, a quantidade `amount` a ser substraída e o atom `:sub`.
  O retorno da função é uma tupla contendo o status da operação de update no banco de dados.
  """
  def perform_operation(account, amount, :sub) do
    account
    |> update_account(%{balance: Decimal.sub(account.balance, amount)})
  end

  @doc """
  A função perform_operation/3 que recebe como último parâmetro o atom `:sum` é responsável por realizar a operação de soma na `account` passada por parâmetro.
  Os argumentos da função são uma struct `account`, a quantidade `amount` a ser somada e o atom `:sum`.
  O retorno da função é uma tupla contendo o status da operação de update no banco de dados.
  """
  def perform_operation(account, amount, :sum) do
    account
    |> update_account(%{balance: Decimal.add(account.balance, amount)})
  end

  @doc """
  Esta função é responsável por validar os dados de `account` antes que eles sejam inseridos no banco de dados.

  Os argumentos da função são:
    1. `account`: É uma struc de account, e representa a conta que será atualizada.
    2. `params`: É um map, e contém os valores a serem atualizados.
  """
  def update_account(%Account{} = account, params) do
    Account.changeset(account, params)
  end

  defp create_transaction_struct(amount, from, to, type) do
    %Transaction{
      value: amount,
      account_from: from,
      account_to: to,
      type: type,
      date: Date.utc_today()
    }
  end
end
