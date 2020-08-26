defmodule BankingApi.Operations do
  @moduledoc """
  Este é o Operations Context.
  Este módulo é responsável por expor as funcionalidades relacionadas às operações de `transfer` e `withdraw`.
  Resumidamente, o objetivo de um context é desacoplar a responsabilidade de models e controllers.
  """

  alias BankingApi.{Accounts, Accounts.Account}
  alias BankingApi.Repo

  @doc """
  Esta função é responsável por operar a transferência bancária entre duas contas.

  Os argumentos desta função são:
    1. `from_id`: O número da conta pagadora (id da conta).
    2. `to_id`: O número da conta recebedora (id da conta).
    3. `amount`: Quantidade a ser transferida.

  O retorno da função é um map contendo o atom `:error` ou `:ok`. Representando o status da operação.

  Um dos possíveis motivos da operação não ser realizada (e retornar um  `error`), é se o valor `amount` a ser transferido é maior do que `from.balance`.
  """
  def transfer(from_id, to_id, amount) do
    from = Accounts.get!(from_id)
    amount = Decimal.new(amount)

    case is_negative?(from.balance, amount) do
      true -> {:error, "O saldo de sua conta não permite fazer uma transferência de R$ #{amount},00. Você não pode fazer transferências maiores que R$ #{from.balance},00"}
      false -> perform_update(from, to_id, amount)
    end
  end

  @doc """
  Esta função é responsável por operar a operação de saque.

  Os argumentos desta função são:
    1. `from_id`: Número da conta (id da conta) que realizará o saque.
    2. `amount`: Quantidade a ser transferida.

  O retorno da função é um map contendo o atom `:error` ou `:ok`. Representando o status da operação.

  Um dos possíveis motivos da operação não ser realizada, é se o valor `amount` é maior do que `from.balance`.
  """
  def withdraw(from_id, amount) do
    from = Accounts.get!(from_id)
    amount = Decimal.new(amount)

    case is_negative?(from.balance, amount) do
      true -> {:error, "O saldo de sua conta não permite fazer uma transferência de R$ #{amount},00. Você não pode fazer transferências maiores que R$ #{from.balance},00"}
      false ->
        {:ok, from} =
          perform_operation(from, amount, :sub)
          |> Repo.update()

        {:ok, "Saque realizado! Saque realizado na conta #{from.id} no valor de #{amount}"}
    end
  end

  defp is_negative?(balance, amount) do
    Decimal.sub(balance, amount)
    |> Decimal.negative?()
  end

  @doc """
  Esta função é responsável validar se a operação de subtração da conta pagadora (`from`) foi concluida, e se for, realizar a operação de soma na conta recebedora (`to_id`)

  Os argumentos da função são:
    1. `from`: É uma struct de `account` e representa a conta pagadora.
    2. `to_id`: É o id da conta recebedora.
    3. `amount`: Quantidade a ser transferida
  """
  def perform_update(from, to_id, amount) do
    to = Accounts.get!(to_id)

    transaction = Ecto.Multi.new()
    |> Ecto.Multi.update(:from, perform_operation(from, amount, :sub))
    |> Ecto.Multi.update(:to, perform_operation(to, amount, :sum))
    |> Repo.transaction()

    case transaction do
      {:ok, _tail} ->
        {:ok, "Transferência concluída! Transferência realizada da conta #{from.id} para a conta #{to.id} no valor de #{amount}"}
      {:error, :from, changeset, _tail} -> {:error, changeset}
      {:error, :to, changeset, _tail} -> {:error, changeset}
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
end
