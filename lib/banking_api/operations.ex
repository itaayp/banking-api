defmodule BankingApi.Operations do
  @moduledoc """
  Este é o Operations Context.
  Este módulo é responsável por expor as funcionalidades relacionadas às operações de `transfer` e `withdraw`.
  Resumidamente, o objetivo de um context é desacoplar a responsabilidade de models e controllers.
  """

  alias BankingApi.{Accounts, Accounts.Account}
  alias BankingApi.Repo

  @doc """
  Esta função é responsável por operar a transferência bancária entre duas contas
  Os argumentos desta função são o id da conta pagadora: `from_id`, o id da conta recebedora: `to_id`, e a quantidade a ser transferida: `amount`
  O retorno da função é um map contendo o atom `:error` ou `:ok`. Representando se o status da operação foi ou não realizada.
  Um dos possíveis motivos da operação não ser realizada, e portando retornar um atom `:error` é se o valor `amount` a ser transferido é maior do que `from.balance`
  """
  def transfer(from_id, to_id, amount) do
    from = Accounts.get!(from_id)
    amount = Decimal.new(amount)

    case is_negative?(from.balance, amount) do
      true -> {:error, "O saldo de sua conta não permite fazer uma transferência de R$ #{amount},00. Você não pode fazer transferências maiores que R$ #{from.balance},00"}
      false -> perform_update(from, to_id, amount)
    end
  end

  defp is_negative?(balance, amount) do
    Decimal.sub(balance, amount)
    |> Decimal.negative?()
  end

  @doc """
  Esta função é responsável validar se a operação de subtração da conta pagadora (`from`) foi concluida, e se for realizar a operação de soma na conta recebedora (`to_id`)
  Os argumentos da função são uma struct de `account` que representa a conta pagadora (`from`), o id da conta recebedora (`to_id`) e a quantidade a ser transferida (`amount`)
  """
  def perform_update(from, to_id, amount) do
    {:ok, from} = perform_operation(from, amount, :sub)
    {:ok, to} = Accounts.get!(to_id)
    |> perform_operation(amount, :sum)
    {:ok, "Transferência concluída! Transferência realizada da conta #{from.id} para a conta #{to.id} no valor de #{amount}"}
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
  Esta função é responsável por realizar a operação de update de uma `account` no banco de dados.
  Os argumentos da função são a struc da `account` que será atualizada, e o map `params` que contém os valores a serem atualizados.
  O retorno da função é uma tupla contendo o status da operação de update no banco de dados.
  """
  def update_account(%Account{} = account, params) do
    Account.changeset(account, params)
    |> Repo.update()
  end
end
