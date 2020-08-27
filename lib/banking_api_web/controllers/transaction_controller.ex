defmodule BankingApiWeb.TransactionController do
  @moduledoc """
  Transaction Controller

  Controller responsável por iniciar qualquer operação no back-end a partir de uma requisição da API relacionada a `/api/transaction`.
  """

  use BankingApiWeb, :controller
  alias BankingApi.Transactions

  action_fallback BankingApiWeb.FallbackController

  @doc """
  Função responsável por buscar e exibir ao usuário final todas as transações armazenadas no banco de dados.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `_params`: Os parâmetros adicionados no request, que neste caso são nulos

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def all(conn, _params) do
    render(conn, "show.json", transaction: Transactions.all())
  end

  @doc """
  Função responsável por buscar e exibir ao usuário final as transações filtradas por `year`.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `%{"year" => year}`: Um map contendo o ano (`year`) que é passado na requisição.

  Observação: o campo `year` deve seguir o formato: `"yyyy"`.

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def year(conn, %{"year" => year}) do
    render(conn, "show.json", transaction: Transactions.year(year))
  end

  @doc """
  Função responsável por buscar e exibir ao usuário final as transações filtradas por mês e ano.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `map`: Um map que contém:
      2.1. `"year" => year`: o ano das transações
      2.2. `"month" => month`:  mês das transações


  Observação:
    1. O campo `year` deve seguir o formato: `"yyyy"`.
    2. O campo `month` deve seguir o formato: `"mm"`

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def month(conn, %{"year" => year, "month" => month}) do
    render(conn, "show.json", transaction: Transactions.month(year, month))
  end

  @doc """
  Função responsável por buscar e exibir ao usuário final as transações filtradas por uma data específica.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `%{"day" => day}`: Um map contendo a data (`day`), que é passada na requisição.

  Obs: O campo `day` deve seguir formato: `"yyyy-mm-dd"`.

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def day(conn, %{"day" => day}) do
    render(conn, "show.json", transaction: Transactions.day(day))
  end
end
