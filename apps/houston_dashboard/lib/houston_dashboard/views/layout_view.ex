defmodule HoustonDashboard.LayoutView do
  use HoustonDashboard, :view

  @doc """
  Returns the current user's session token.
  """
  def user_token(conn), do: conn.private[:user_token]

  @doc """
  Returns a slugified class name for the `body` tag based on the full current
  path.
  """
  def full_path_class(%Plug.Conn{request_path: "/"}),
    do: full_path_class("homepage")
  def full_path_class(%Plug.Conn{request_path: path}), do: full_path_class(path)
  def full_path_class(path) when is_binary(path) do
    path
    |> String.replace("/", "-")
    |> String.trim("-")
  end

  @doc """
  Returns a slugified class name for the `body` tag based on the namespace of
  the called controller.
  """
  def namespace_class(%Plug.Conn{} = conn) do
    controller = Map.get(conn.private, :phoenix_controller) |> IO.inspect()

    controller
    |> to_string()
    |> String.replace("Elixir.HoustonDashboard.", "")
    |> String.split(".")
    |> hd()
    |> String.trim()
    |> String.downcase()
    # TODO: Remove Elixir.HoustonDashboard.
    # TODO: Lowercase here
  end

  @doc """
  Returns space seperated classes for the `body` tag based on teh full path and
  namespace of the called controller. This is attached to every layout and is
  primarily used for CSS styling.
  """
  def body_classes(%Plug.Conn{} = conn) do
    full_path_class(conn) <> " " <> namespace_class(conn)
  end
end
