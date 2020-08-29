defmodule BankingApi.Accounts.Auth.Pipeline do
  @moduledoc """
  O objetivo deste módulo é restringir o acesso aos endpoints da aplicação somente para usuários que estejam logados.
  Para isso, este módulo foi adicionado ao `pipe_through` do router.ex
  """

  use Guardian.Plug.Pipeline,
    otp_app: :banking_api,
    module: BankingApi.Accounts.Auth.Guardian,
    error_handler: BankingApi.Accounts.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
