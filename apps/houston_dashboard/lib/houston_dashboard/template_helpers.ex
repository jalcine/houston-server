defmodule HoustonDashboard.TemplateHelpers do
  @doc """
  Returns a slugified class name for the `body` tag based on the current path.
  """
  def body_class(%Plug.Conn{request_path: "/"}), do: body_class("home")
  def body_class(%Plug.Conn{} = conn), do: body_class(conn.request_path)

  def body_class(path) when is_binary(path) do
    path
    |> String.replace("/", "-")
    |> String.trim("-")
  end
end
