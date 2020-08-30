defmodule BankingApi.Transactions.Helper do
  @moduledoc """
    Modulo helper ao `Transactions Context`
  """
  #! Developer:
  #! `Date.from_erl!` é usado para converter a data para o formato do banco de dados, e assim manipular dados do BD
  import Ecto.Query, warn: false
  alias BankingApi.Repo
  alias BankingApi.Transactions.Transaction

  @doc """
  A função busca todos os registros da tabela `transactions`.

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> Helper.list_transactions()
      [%Transactions{}, ...]
  """
  def list_transactions, do: Repo.all(Transaction)

  @doc """
  A função busca os registros da tabela `transactions` inseridos no ano `year`.

  O argumento da função é:
  1. `year`: O ano em formato integer. O ano deve seguir o formato: `yyyy`.

  O retorno da função é um map que contém o total transacionado e uma lista de `transaction structs`

  ## Examples
      iex> Helper.query_by_year(2020)
      %{total: #Decimal<100>, transactions: [%Transactions{}, ...]}
  """
  def query_by_year(year) do
    start_date = Date.from_erl!({year, 01, 01})
    end_date = Date.from_erl!({year, 12, 31})

    do_query(start_date, end_date)
  end

  @doc """
  A função busca os registros da tabela `transactions` inseridos no ano `year` e no mês `month`.

  Os argumentos da função são:
    1. `year`: O ano em formato `integer`. O ano deve seguir o formato: `yyyy`.
    2. `month`: O mês em formato `integer`. O mês deve seguir o formato: `mm`

  O retorno da função é um map que contém o total transacionado e uma lista de `transaction structs`

  ## Examples
      iex> Helper.query_by_month(2020, 10)
      %{total: #Decimal<100>, transactions: [%Transactions{}, ...]}
  """
  def query_by_month(year, month) do
    start_date = Date.from_erl!({year, month, 01})
    days_in_month = Date.days_in_month(start_date)
    end_date = Date.from_erl!({year, month, days_in_month})

    do_query(start_date, end_date)
  end

  @doc """
  A função busca os registros da tabela `transactions` inseridos no dia especificado.

  O argumento da função é:
    1. `date`: A data em formato string. A data deve seguir o formato: `"yyyy-mm-dd"`.

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> Helper.query_by_day("2009-01-01")
      [%Transactions{}, ...]
  """
  def query_by_day(date) do
    query = from t in Transaction, where: t.date == ^Date.from_iso8601!(date)
    Repo.all(query)
  end

  @doc """
  A função monta e executa a query que sera executada na tabela `tranactions`.

  A consulta no banco de dados é feita baseada em um período de tempo. Portanto, os argumentos da função são:
    1. `start_date`: O primeiro dia a ser levado em consideração para a consulta. A variável é do tipo string e deve seguir o formato `"yyyy-mm-dd"`
    2. `end_date`: O último dia a ser levado em consideração para a consulta. A variável é do tipo string e deve seguir o formato `"yyyy-mm-dd"`

  O retorno da função é um map com duas keys:
    1. `total`: O valor total transacionado
    2. `transactions`: Uma lista de `transaction structs`

  ## Examples
      iex> Helper.do_query("2020-01-01", "2020-12-30")
      %{total: #Decimal<100>, transactions: [%Transactions{}, ...]}

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

  ## Examples
      iex> transactions = [ %{
          value: "100",
          account_from: "1",
          type: "withdraw",
          account_to: "~",
          date: ~D[2019-10-30]
        }]
      iex> Helper.create_report(transactions)
      %{
        total: #Decimal<100>,
        transactions: [%{account_from: "1", account_to: "~", date: ~D[2019-10-30], type: "withdraw", value: "100"}]
      }
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
  def sum_amount(transactions) do
    # Foi preciso fazer a soma das quantias usando `Enum.reduce` e `Decimal.new` para evitar um resultado do tipo: `1.3e3`
    # `Enum.reduce` soma cada valor de `transaction.value`. E o primeiro valor a ser somado é o segundo argumento da função (`0`)
    Enum.reduce(transactions, Decimal.new("0"), fn transaction, acc ->
      Decimal.add(acc, transaction.value)
    end)
  end

  @doc """
  Valida se o ano, mês ou dia são uma string vazia ou contém o caractére `"-"`.

  Os argumentos da função são:
    1. `date`: Pode ser o ano, o mês ou o dia, em formato string, a ser validado
    2. `fail_message`: A mensagem a ser exibida ao usuário caso a data passada esteja inválida

  Os dois possíveis retornos da função são uma túpla contendo o atom `:ok`, caso a data seja válida, ou uma tupla contendo o atom `:error` e a mensagem `fail_message`, caso a data seja inválida

  ## Examples
      iex> Helper.validate_date("2020", "this is an invalid year")
      {:ok, "A data é válida"}

      iex> Helper.validate_date("-2020", "this is an invalid year")
      {:error, "this is an invalid year"}
  """
  def validate_date(date, fail_message) do
    if String.equivalent?(date, "") || String.contains?(date, "-") do
      {:error, fail_message}
    else
      {:ok, "A data é válida"}
    end
  end
end
