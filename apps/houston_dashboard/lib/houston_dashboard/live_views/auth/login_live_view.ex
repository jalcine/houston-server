defmodule HoustonDashboard.Auth.LoginLiveView do
  use HoustonDashboard, :live_view

  alias HoustonDashboard.Auth

  def mount(params, socket) do
    changeset =
      params
      |> Map.get(:params, %{})
      |> Auth.LoginForm.process_params()

    {:ok, assign(socket, %{
      changeset: changeset,
      csrf_token: Map.get(params, :csrf_token)
    })}
  end

  def render(assigns), do: Auth.LoginView.render("index.html", assigns)

  def handle_event("validate", %{"user" => params}, socket) do
    changeset = Auth.LoginForm.process_params(params)

    {:noreply, assign(socket, changeset: changeset)}
  end
end
