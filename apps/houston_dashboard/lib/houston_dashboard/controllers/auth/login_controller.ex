defmodule HoustonDashboard.Auth.LoginController do
  use HoustonDashboard, :controller

  alias Houston.Accounts
  alias HoustonDashboard.Auth

  def index(conn, _params) do
    live_render(conn, Auth.LoginLiveView, session: %{
      csrf_token: Phoenix.Controller.get_csrf_token()
    })
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.login(user_params["username"], user_params["password"]) do
      {:ok, session} ->
        conn
        |> put_session(:user_token, session.token)
        |> redirect(to: "/")
      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> live_render(Auth.LoginLiveView, session: %{
          csrf_token: Phoenix.Controller.get_csrf_token(),
          params: user_params
        })
    end
  end
end
