defmodule BankingApiWeb.ErrorView do
  use BankingApiWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  @doc """
  Retorna ao usuário final uma mensagem de erro.

  Os argumentos da função são:
    1. A string `error_message.json`
    2. %{message: message}: Um map que contenha o valor da mensagem de erro `message`
  """
  def render("error_message.json", %{message: message}) do
    %{erro: message}
  end
end
