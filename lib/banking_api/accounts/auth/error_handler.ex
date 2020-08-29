defmodule BankingApi.Accounts.Auth.ErrorHandler do
  @moduledoc """
    Este é o módulo que trata os erros de autenticação
  """

  import Plug.Conn

  @doc """
  Função que trata a resposta de erro relacionada a autenticação.

  Os argumentos da função são:
    1. `conn`: Informações sobre a conexão e a request
    2. `type`: É o motivo do erro de atutenticação
  """
  def auth_error(conn, {type, _reason}, _opts) do
    body = Poison.encode!(%{error: to_string(type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
