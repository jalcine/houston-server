defmodule Elementary.HoustonServerWeb.FallbackController do
  use Elementary.HoustonServerWeb, :controller

  def call(conn, {:error, :timeout}) do
    conn
    |> put_status(:unavailable)
    |> put_view(Elementary.HoustonServerWeb.ErrorView)
    |> render(:"503")
  end
end
