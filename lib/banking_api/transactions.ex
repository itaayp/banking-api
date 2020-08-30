defmodule BankingApi.Transactions do
  @moduledoc """
  Transactions Context.

  Este módulo é responsável por buscar no banco de dados as transações armazenadas na tabela `transactions`.

  Resumidamente, o objetivo de um context é desacoplar a responsabilidade de models e controllers.
  """

  import Ecto.Query, warn: false
  alias BankingApi.Repo
  alias BankingApi.Transactions.Helper
  alias BankingApi.Transactions.Transaction

  @doc """
  Retorna as transações armazenadas no banco de dados, e a soma da quantia de todas as transações.

  O retorno da função é um map contendo o total transacionado e a lista de transações: `%{total: 1000, transactions: [%Transactions{}, ...]}`

  ## Examples
      iex> Transactions.all()
      %{total: 100, transactions: [%Transactions{}, ...]}
  """
  def all do
    Helper.list_transactions()
    |> Helper.create_report()
  end

  @doc """
  Retorna as transações ocorridas no ano `year` e a quantia total transacionada na data.

  O argumento da função é:
  `year`: O ano em formato string. O ano deve seguir o formato: `"yyyy"`.

  O retorno da função é um map contendo o total transacionado e a lista de transações: `%{total: 1000, transactions: [%Transactions{}, ...]}`

  ## Examples
      iex> Transactions.year("2020")
      %{total: 33, transactions: [%Transactions{}, ...]}
  """
  def year(year) do
    Helper.query_by_year(String.to_integer(year))
  end

  @doc """
  Retorna as transações ocorridas no mês `month` do ano `year` e a quantia total transacionada na data.

  Os argumentos da função são:
    1. `year`: O ano em formato string. O ano deve seguir o formato: `"yyyy"`.
    2. `month`: O mês em formato string. O mês deve seguir o formato: `"mm"`

  O retorno da função é um map e segue o padrão: `%{total: 1000, transactions: [%Transactions{}, ...]}`

  ## Examples
      iex> Transactions.month("2020", "02")
      %{total: 22, transactions: [%Transactions{}, ...]}
  """
  def month(year, month) do
    Helper.query_by_month(
      String.to_integer(year),
      String.to_integer(month)
    )
  end

  @doc """
  Retorna as transações ocorridas na data `date` e a quantia total transacionada na data.

  O argumento da função é:
    1. `date`: A data em formato string. A data deve seguir o formato: `"yyyy-mm-dd"`.

  O retorno da função é um map e segue o padrão: `%{total: 1000, transactions: [%Transactions{}, ...]}`

  ## Examples
      iex> Transactions.day("2020-02-02")
      %{total: 22, transactions: [%Transactions{}, ...]}
  """
  def day(date) do
    Helper.query_by_day(date)
    |> Helper.create_report()
  end

  @doc """
  Insere a `transaction` no banco de dados.

  O argumento da função é o map `params` que contém todos os valores a serem inseridos na tabela `transactions`.
  Os valores do map `params` e obrigatoriedade de cada um deles são definidos pela `transaction model`

  O retorno da função é uma tupla, e retornará o atom `:ok`, caso a inserção tenha ocorrido com sucesso, ou `:error`, caso haja falha durante a inserção.

  ## Examples
      iex> Transactions.insert_transaction(%{value: "111", account_from: "3", account_to: "~", type: "withdraw", date: "2019-02-02"})
      {:ok, %Transaction{}}
  """
  def insert_transaction(params) do
    %Transaction{}
    |> Transaction.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Chama a função `BankingApi.Transactions.Helper.validate_date/2` que faz a validação de data.

  Os argumentos da função são:
    1. `date`: A data, em formato string, a ser validada
    2. `fail_message`: A mensagem a ser exibida ao usuário caso a data passada esteja inválida

  Os dois possíveis retornos da função são uma túpla contendo o atom `:ok`, caso a data seja válida, ou uma tupla contendo o atom `:error` e a mensagem `fail_message`, caso a data seja inválida

  ## Examples
      iex> Transactions.validate_date("2020", "this is an invalid year")
      {:ok, "A data é válida"}

      iex> Transactions.validate_date("-2020", "this is an invalid year")
      {:error, "this is an invalid year"}
  """
  def validate_date(date, fail_message) do
    Helper.validate_date(date, fail_message)
  end
end
