defmodule Elementary.HoustonServerWeb.IndexLive do
  @moduledoc false

  use Elementary.HoustonServerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    new_socket =
      socket
      |> assign(:page_title, "Developer")

    {:ok, new_socket}
  end

  @impl true
  def render(assigns) do
    Elementary.HoustonServerWeb.IndexView.render("index.html", assigns)
  end
end
