defmodule BankingApiWeb.TransactionViewTest do
  use BankingApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @transaction %{
    transactions: [
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: "2020-08-30"
      },
      %{
        value: "100",
        account_from: "1",
        type: "withdraw",
        account_to: "~",
        date: "2020-08-30"
      }
    ],
    total: "200"
  }

  describe "render show.json" do
    test "render show.json" do
      # do
      result =
        render_to_string(BankingApiWeb.TransactionView, "show.json", %{transaction: @transaction})

      # assert
      assert String.contains?(result, "\"Total operado\":\"R$ 200\"") == true
      assert String.contains?(result, "\"Conta de destino\":\"2\"") == true
      assert String.contains?(result, "\"Conta de destino\":\"~\"") == true
    end
  end
end
