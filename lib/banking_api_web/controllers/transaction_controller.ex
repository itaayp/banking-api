defmodule BankingApiWeb.TransactionController do
  @moduledoc """
  Transaction Controller

  Controller responsável por iniciar qualquer operação no back-end a partir de uma requisição da API relacionada a `/api/transaction`.
  """

  use BankingApiWeb, :controller
  alias BankingApi.Transactions

  action_fallback BankingApiWeb.FallbackController

  plug :is_admin?
       when action in [
              :generate_entire_life_report,
              :generate_anual_report,
              :generate_monthly_report,
              :generate_daily_report
            ]

  @year_fail_message "Você precisa inserir um ano válido. Leia a documentação para mais informações (https://documenter.getpostman.com/view/3587450/TVCfW8eJ#eed0a685-1f28-4e7a-8f36-e549f763e920)"
  @month_fail_message "Você precisa inserir um mês válido. Leia a documentação para mais informações (https://documenter.getpostman.com/view/3587450/TVCfW8eJ#eed0a685-1f28-4e7a-8f36-e549f763e920)"
  @day_fail_message "Você precisa inserir uma data válida. Leia a documentação para mais informações (https://documenter.getpostman.com/view/3587450/TVCfW8eJ#eed0a685-1f28-4e7a-8f36-e549f763e920)"

  @doc """
  Função responsável por buscar e exibir ao usuário final todas as transações armazenadas no banco de dados.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `_params`: Os parâmetros adicionados no request, que neste caso são nulos

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def generate_entire_life_report(conn, _params) do
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
  def generate_anual_report(conn, %{"year" => year}) do
    # it's necessary to pass a valid month as a parameter to Transactions.validate_date
    case Transactions.validate_date(year, "01", @year_fail_message) do
      {:ok, _message} -> render(conn, "show.json", transaction: Transactions.year(year))
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Função responsável por buscar e exibir ao usuário final as transações filtradas por mês e ano.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `map`: Um map que contém:
      * `"year" => year`: o ano das transações
      * `"month" => month`:  mês das transações


  Observação:
    1. O campo `year` deve seguir o formato: `"yyyy"`.
    2. O campo `month` deve seguir o formato: `"mm"`

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def generate_monthly_report(conn, %{"year" => year, "month" => month}) do
    with {:ok, _message} <- Transactions.validate_date(year, month, @month_fail_message) do
      render(conn, "show.json", transaction: Transactions.month(year, month))
    end
  end

  @doc """
  Função responsável por buscar e exibir ao usuário final as transações filtradas por uma data específica.

  Os argumentos da função são:
    1. `conn`: as informações da conexão
    2. `%{"day" => day}`: Um map contendo a data (`day`), que é passada na requisição.

  Obs: O campo `day` deve seguir formato: `"yyyy-mm-dd"`.

  O retorno da função é o feedback da requisição, que em caso de sucesso é localizado em `show.json` e em caso de falha é localizado em `BankingApiWeb.FallbackController`
  """
  def generate_daily_report(conn, %{"day" => day}) do
    with {:ok, _message} <- Transactions.validate_day(day, @day_fail_message) do
      render(conn, "show.json", transaction: Transactions.day(day))
    end
  end

  # Antes de qualquer função especificada na declaração do `plug`, a função `is_admin?` será chamada
  defp is_admin?(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    if user.role == "admin" do
      conn
    else
      conn
      |> put_status(401)
      |> json(%{error: "Acesso negado. Você não tem permissão para acessar este relatório."})
    end
  end
end
