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
  `year`: O ano em formato string. O ano deve seguir o formato: `"yyyy"`.

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> query_by_year(year)
      [%Transactions{}, ...]
  """
  def query_by_year(year) do
    year = String.to_integer(year)
    start_date = Date.from_erl!({year, 01, 01})
    end_date = Date.from_erl!({year, 12, 31})
    query = from t in Transaction, where: t.date >= ^start_date and t.date <= ^end_date
    Repo.all(query)
  end

  @doc """
  A função busca todos os registros da tabela `transactions` inseridos no ano `year` e no mês `month`.

  Os argumentos da função são:
    1. `year`: O ano em formato string. O ano deve seguir o formato: `"yyyy"`.
    2. `month`: O mês em formato string. O mês deve seguir o formato: `"mm"`

  O retorno da função é uma lista de `transaction structs`

  ## Examples
      iex> query_by_month(year, month)
      [%Transactions{}, ...]
  """
  def query_by_month(year, month) do
    year = String.to_integer(year)
    month = String.to_integer(month)
    start_date = Date.from_erl!({year, month, 01})
    # `Date.days_in_month(start_date)` retorna a quantidade de dias no mês
    days_in_month = Date.days_in_month(start_date)
    end_date = Date.from_erl!({year, month, days_in_month})
    query = from t in Transaction, where: t.date >= ^start_date and t.date <= ^end_date
    Repo.all(query)
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
end
