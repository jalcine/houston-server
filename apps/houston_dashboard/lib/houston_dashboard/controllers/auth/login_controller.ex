defmodule HoustonDashboard.Auth.LoginController do
  use HoustonDashboard, :controller

  alias Houston.Accounts
  alias HoustonDashboard.Auth

  def index(conn, _params) do
    render(conn, "index.html", %{
      username_or_email: "",
      error: ""
    })
  end

  def create(conn, %{"login" => login_params}) do
    %{
      "username_or_email" => username_or_email,
      "password" => password
    } = login_params

    case Accounts.login(username_or_email, password) do
      {:ok, session} ->
        conn
        |> put_session(:user_token, session.token)
        |> redirect(to: "/")

      {:error, message} ->
        render(conn, "index.html", %{
          username_or_email: username_or_email,
          error: message
        })
    end
  end
end
