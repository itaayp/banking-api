defmodule BankingApiWeb.OperationViewTest do
  use BankingApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  describe "operation_succeeded.json" do
    test "operation_succeeded.json" do
      # do
      result =
        render_to_string(BankingApiWeb.OperationView, "operation_succeeded.json", %{
          message: "such a beautiful message"
        })

      # assert
      assert String.contains?(result, "such a beautiful message") == true
    end
  end
end
