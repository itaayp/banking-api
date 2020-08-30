defmodule BankingApiWeb.OperationView do
  @moduledoc """
  Operation View.

  Módulo responsável por renderizar ao usuário final o feedback positivo de operações bancárias realizadas
  """

  use BankingApiWeb, :view

  @doc """
  Renderiza ao usuário final o feedback de que a operação realizada foi bem sucedida.

  Os argumentos da função são:
    1. A string `"operation_succeeded.json"`
    2. `%{message: message}`: um map que contenha:
      2.1. `message`: a mensagem que será exibida ao usuário
  """
  def render("operation_succeeded.json", %{message: message}) do
    %{
      message: message
    }
  end
end
