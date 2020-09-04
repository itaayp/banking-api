defmodule BankingApi.Operations do
  @moduledoc """
  Operations Context.

  Este módulo é responsável por expor as funcionalidades que atuam sobre as operações `transfer` e `withdraw`.

  Resumidamente, o objetivo de um context é desacoplar a responsabilidade de models e controllers.
  """

  alias BankingApi.{Accounts, Accounts.Account}
  alias BankingApi.Repo
  alias BankingApi.Transactions.Transaction
  alias Ecto.Multi

  # variáveis de módulo
  @withdraw "withdraw"
  @transfer "transfer"

  @your_account_balance_is "O saldo de sua conta bancária é R$"

  @transfer_succeeded_from_account "Transferência realizada da conta"
  @to_account "para a conta"
  @in_the_amount_of "no valor de R$"

  @withdraw_succeeded "Saque realizado"
  @from_account "da conta"

  @denied_operation "Operação negada"
  @you_tried_to_operate_an_amount_greater_than_your_balance "Você tentou operar um valor maior do que o permitido para a sua conta"

  @doc """
  Inicia a operação de transferência bancária.

  Os argumentos desta função são:
    1. `from`: É a `account struct` da conta pagadora.
    2. `to_id`: O número da conta recebedora (id da conta).
    3. `amount`: Quantidade a ser transferida.

  Há três possíveis retornos para a função. Eles podem ser:
    1. `{:ok, message}`: Caso a transferência tenha ocorrido com sucesso
    2. `{:error, message}`: Caso o saldo da conta seja menor do que o valor a ser transferido.
    3. Qualquer retorno da função `handle_feedback/2`

  Um dos possíveis motivos da operação não ser realizada (e retornar `error`), é se o valor `amount` a ser transferido é maior do que `from.balance`.

  ## Examples
      iex> from = %Account{balance: "1000.00", user_id: "1"}
      iex> Operations.transfer(from, "2", "50.00")
      {:ok, "Transferência realizada da conta 1 para a conta 2 no valor de R$ 50.00. O saldo de sua conta bancária é R$ 950.00"}
  """
  def transfer(from, to_id, amount) do
    case is_negative?(from.balance, amount) do
      true ->
        {:error,
         "#{@denied_operation}. #{@you_tried_to_operate_an_amount_greater_than_your_balance}. #{
           @your_account_balance_is
         } #{from.balance}."}

      false ->
        transfer_operation(from, to_id, amount)
    end
  end

  defp transfer_operation(from, to_id, amount) do
    to = Accounts.get!(to_id)
    new_balance = Decimal.sub(from.balance, amount)

    if to != nil do
      Multi.new()
      |> Multi.update(:to, perform_operation(to, amount, :sum))
      |> subtract_from_account(from, amount, to_id, @transfer)
      |> handle_feedback(
        "#{@transfer_succeeded_from_account} #{from.id} #{@to_account} #{to.id} #{
          @in_the_amount_of
        } #{amount}. #{@your_account_balance_is} #{new_balance}"
      )
    else
      handle_feedback(
        {:error, reason: "the target account does not exist"},
        "A conta que você tentou transferir não existe."
      )
    end
  end

  @doc """
  Inicia a operação de saque.

  Os argumentos desta função são:
    1. `from`: É a `account struct` de onde será feito saque.
    2. `amount`: Quantidade a ser transferida.

  Há três possíveis retornos para a função. Eles podem ser:
    1. `{:ok, message}`: Caso o saque tenha ocorrido com sucesso
    2. `{:error, message}`: Caso o saldo da conta seja menor do que o valor de saque.
    3. Qualquer retorno da função `handle_feedback/2`

  Um dos possíveis motivos da operação não ser realizada, é se o valor `amount` é maior do que `from.balance`.

  ## Examples
      iex> from = %Account{balance: "1000.00", user_id: "1"}
      iex> Operations.withdraw(from, "50.00")
      {:ok, "Saque realizado no valor de R$ 50.00 da conta 1. O saldo de sua conta bancária é R$ 950.00"}
  """
  def withdraw(from, amount) do
    case is_negative?(from.balance, amount) do
      true ->
        {:error,
         "#{@denied_operation}. #{@you_tried_to_operate_an_amount_greater_than_your_balance}. #{
           @your_account_balance_is
         } #{from.balance}."}

      false ->
        withdraw_operation(from, amount)
    end
  end

  defp withdraw_operation(from, amount) do
    new_balance = Decimal.sub(from.balance, amount)

    Multi.new()
    |> subtract_from_account(from, amount, "~", @withdraw)
    |> handle_feedback(
      "#{@withdraw_succeeded} #{@in_the_amount_of} #{amount} #{@from_account} #{from.id}. #{
        @your_account_balance_is
      } #{new_balance}"
    )
  end

  defp subtract_from_account(multi, from, amount, to_id, operation_type) do
    Multi.update(multi, :from, perform_operation(from, amount, :sub))
    |> Multi.insert(
      :transaction,
      create_transaction_struct(amount, Integer.to_string(from.id), to_id, operation_type)
    )
    |> Repo.transaction()
  end

  defp is_negative?(balance, amount) do
    Decimal.sub(balance, amount)
    |> Decimal.negative?()
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

      {:error, _reason} ->
        {:error, message}
    end
  end

  @doc """
  Faz a subtração de `amount` na conta bancária.

  Os argumentos da função são:
    1. `account`: É uma `account struct`
    2. `amount`: É a quantidade a ser substraída
    3. O atom `:sub`.

  O retorno da função é uma tupla contendo o status da operação de update no banco de dados.
  """
  def perform_operation(account, amount, :sub) do
    account
    |> update_account(%{balance: Decimal.sub(account.balance, amount)})
  end

  @doc """
  Faz a soma de `amount` na conta bancária.

  Os argumentos da função são:
    1. `account`: É uma `account struct`
    2. `amount`: É a quantidade a ser somada
    3. O atom `:sum`.

  O retorno da função é uma tupla contendo o status da operação de update no banco de dados.
  """
  def perform_operation(account, amount, :sum) do
    account
    |> update_account(%{balance: Decimal.add(account.balance, amount)})
  end

  @doc """
  Valida os dados de `account` antes que eles sejam inseridos no banco de dados.

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

  @doc """
  Verifica se está transferindo para a mesma conta.

  Os argumentos da função são:
    1. `from`: `account struct` da conta que realizará a transferência
    2. `to_id`: id da conta que receberá a transferência

  ## Examples
      iex> from = %Account{balance: "1000.00", user_id: "1"}
      iex> Operations.is_transfering_to_same_account?(from, "1")
      {:error, "Você não pode transferir para a sua própria conta"}
  """
  def is_transfering_to_same_account?(from, to_id) do
    if String.equivalent?(Integer.to_string(from.id), to_id) do
      {:error, "Você não pode transferir para a sua própria conta"}
    else
      false
    end
  end
end
