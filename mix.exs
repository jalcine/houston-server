defmodule Elementary.HoustonServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :houston_server,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      preferred_cli_env: preferred_cli_env(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      extra_applications: [:cachex, :logger, :runtime_tools],
      mod: {Elementary.HoustonServer.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cachex, "~> 3.3"},
      {:castore, "~> 0.1.0"},
      {:decimal, "~> 2.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:mint, "~> 1.2.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_view, "~> 0.15.0"},
      {:phoenix, "~> 1.5.5"},
      {:plug_cowboy, "~> 2.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:tesla, "~> 1.3.0"},
      {:credo, "~> 1.4", only: :dev, runtime: false},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:floki, ">= 0.27.0", only: :test},
      {:wallaby, "~> 0.28.0", runtime: false, only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "cmd npm ci --prefix assets"],
      "test.unit": ["test test/houston_server test/houston_server_web"],
      "test.browser": ["test test/houston_server_client"]
    ]
  end

  defp preferred_cli_env do
    [
      "test.unit": :test,
      "test.browser": :test
    ]
  end
end
