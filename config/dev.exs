use Mix.Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure the Houston database
config :houston, Houston.Repo,
  username: "postgres",
  password: "postgres",
  database: "houston_dev",
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :houston_dashboard, HoustonDashboard.Endpoint,
  http: [port: 4000],
  https: [
    port: 4001,
    cipher_suite: :strong,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :houston_dashboard, HoustonDashboard.Endpoint,
  live_reload: [
    patterns: [
      ~r{lib/houston_dashboard/forms/.*(ex)$},
      ~r{lib/houston_dashboard/live_views/.*(ex)$},
      ~r{lib/houston_dashboard/templates/.*(eex)$},
      ~r{lib/houston_dashboard/views/.*(ex)$},
      ~r{priv/gettext/.*(po)$},
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$}
    ]
  ]

# Configure the HoustonLegacy database
config :houston_legacy, HoustonLegacy.Repo, database: "houston_dev"
