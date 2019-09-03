defmodule HoustonLegacy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      repo_child()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HoustonLegacy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp repo_child() do
    config =
      :houston_legacy
      |> Application.get_env(HoustonLegacy.Repo)
      |> Keyword.merge(name: HoustonLegacy.Repo)

    worker(Mongo, [config])
  end
end
