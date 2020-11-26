defmodule Elementary.HoustonServerWeb.FooterLive do
  @moduledoc false

  use Elementary.HoustonServerWeb, :live_view

  alias Elementary.HoustonServerWeb.Gettext, as: Gtext

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Elementary.HoustonServerWeb.LayoutView.render("footer.html", assigns)
  end
end
