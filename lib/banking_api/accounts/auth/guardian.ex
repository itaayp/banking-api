defmodule BankingApi.Accounts.Auth.Guardian do
  @moduledoc """
  Módulo responsável por lidar com as funcionalidades de autenticação do Guardian.

  Conceitos importantes sobre o guardian:
    1. `claims`: informações sobre o token, como, tempo de duração, tipo de acesso, subject e o próprio token
    2. `resource`: O que será autenticado. No nosso caso, o `user`.
    3. `token`: É um hash muito grande que armazena as informações de todas as claims.
    4. `subject` ou `sub`: É um identificador curto que é usado para identificar a `resource`
  """

  use Guardian, otp_app: :banking_api
  alias BankingApi.Accounts.Auth.Session
  alias BankingApi.Accounts

  @doc """
  Faz a autenticação do usuário no sistema e cria o token de autenticação

  Argumentos para a função:
    1. `email`: email do usuário
    2. `senha`: senha do usuário

  Existem dois possíveis retornos da função:
    1. `{:error, :unauthorized}`: Caso falhe a autenticação
    2. `{:ok, user, token}`: Onde, `user` é uma `user struct` já com as informações de `account` e `token` é o token gerado pelo Guardian
  """
  def authenticate(email, password) do
    case Session.authenticate(email, password) do
      {:ok, user} -> create_token(user)
      _any -> {:error, :unauthorized}
    end
  end

  @doc """
  Busca o `subject` do `token` do `user`.
  """
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  defp resource_from_claims(claims) do
    id = claims["sub"]
    {:ok, Accounts.get_user!(id)}
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
