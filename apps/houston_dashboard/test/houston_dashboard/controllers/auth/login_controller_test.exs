defmodule HoustonDashboard.Auth.LoginControllerTest do
  use HoustonDashboard.BrowserCase

  setup do
    @endpoint
    |> Routes.login_path(:index)
    |> navigate_to()

    :ok
  end

  test "login redirects to homepage after success" do
    AccountsFactory.insert(:user, %{
      email: "admin@elementary.io",
      password: "password"
    })

    submit_form("form", %{
      "#login_username_or_email": "admin@elementary.io",
      "#login_password": "password"
    })

    assert current_path() == Routes.homepage_path(@endpoint, :index)
  end

  test "login shows error after unsuccessful login" do
    submit_form("form", %{
      "#login_username_or_email": "fake@elementary.io",
      "#login_password": "incorrect"
    })

    assert current_path() == Routes.login_path(@endpoint, :index)
    assert String.contains?(visible_page_text(), "Incorrect")
  end
end
