defmodule BankingApi.Transactions.Helper do
  @moduledoc """
    Modulo helper para suporte ao Transactions' context
  """
  #!Developer:
  #! `^` é usado para passar valores como parâmetro em queries
  #! `Date.from_erl!` é usado para converter a data passada como parâmetro para o formato do banco de dados, e então manipular dados do BD
  import Ecto.Query, warn: false
  alias BankingApi.Repo
  alias BankingApi.Transactions.Transaction

  @doc """
  A função busca todos os registros da tabela `transactions`.

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> list_transactions()
      [%Transactions{}, ...]
  """
  def list_transactions, do: Repo.all(Transaction)

  @doc """
  A função busca todos os registros da tabela `transactions` inseridos no ano `year`.

  O argumento da função é:
  `year`: O ano em formato integer. O ano deve seguir o formato: `yyyy`.

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> query_by_year(year)
      [%Transactions{}, ...]
  """
  def query_by_year(year) do
    start_date = Date.from_erl!({year, 01, 01})
    end_date = Date.from_erl!({year, 12, 31})

    do_query(start_date, end_date)
  end

  @doc """
  A função busca todos os registros da tabela `transactions` inseridos no ano `year` e no mês `month`.

  Os argumentos da função são:
    1. `year`: O ano em formato `integer`. O ano deve seguir o formato: `yyyy`.
    2. `month`: O mês em formato `integer`. O mês deve seguir o formato: `mm`

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> query_by_month(year, month)
      [%Transactions{}, ...]
  """
  def query_by_month(year, month) do
    start_date = Date.from_erl!({year, month, 01})

    # `Date.days_in_month(start_date)` retorna a quantidade de dias no mês
    days_in_month = Date.days_in_month(start_date)
    end_date = Date.from_erl!({year, month, days_in_month})

    do_query(start_date, end_date)
  end

  @doc """
  A função busca todos os registros da tabela `transactions` inseridos no ano `year` e no mês `month`.

  O argumento da função é:
    1. `date`: A data em formato string. A data deve seguir o formato: `"yyyy-mm-dd"`.

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> query_by_day(date)
      [%Transactions{}, ...]
  """
  def query_by_day(date) do
    query = from t in Transaction, where: t.date == ^Date.from_iso8601!(date)
    Repo.all(query)
  end

  @doc """
  A função monta e executa a query que retornará as tranactions no banco de dados.

  A consulta no banco de dados é feita baseada em um período de tempo. Portanto, os argumentos da função são:
    1. `start_date`: O primeiro dia a ser levado em consideração para a consulta.
    2. `end_date`: O último dia a ser levado em consideração para a consulta.

  O retorno da função é um map com duas keys:
    1. `total`: O valor total transacionado
    2. `transactions`: Uma lista de `transaction structs`
  """
  def do_query(start_date, end_date) do
    query = from t in Transaction, where: t.date >= ^start_date and t.date <= ^end_date

    Repo.all(query)
    |> create_report()
  end

  @doc """
  A função monta o que será o report de transações.

  O argumento da função é:
    1. `transactions`: Uma lista de `transaction structs`

  O retorno da função é um map com duas keys:
    1. `total`: O valor total transacionado
    2. `transactions`: Uma lista de `transaction structs`
  """
  def create_report(transactions) do
    # Prepara o report de transações: soma o total operacionado e adiciona a lista de `transactions` em um map
    %{total: sum_amount(transactions), transactions: transactions}
  end

  @doc """
  A função é responsável por somar os valores de `transaction.value` de todas as structs passadas dentro da lista `transactions`

  O argumento da função é a lista `transactions` que contém as structs de `transaction`

  O retorno da função é o resultado da soma de todas as `transaction.value` da lista
  """
  def sum_amount(trasactions) do
    # Foi preciso fazer a soma das quantias usando `Enum.reduce` e `Decimal.new` para evitar um resultado do tipo: `1.3e3`
    # `Enum.reduce` soma cada valor de `transaction.value`. E o primeiro valor a ser somado é o segundo argumento da função (`0`)
    Enum.reduce(trasactions, Decimal.new("0"), fn transaction, acc ->
      Decimal.add(acc, transaction.value)
    end)
  end
end
