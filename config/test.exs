use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Setup hound for browser testing.
config :hound,
  driver: System.get_env("WEBDRIVER") || "phantomjs",
  browser: System.get_env("BROWSER") || "phantomjs",
  path_prefix: "",
  app_port: 4099

# Configure the Houston database
config :houston, Houston.Repo,
  username: "postgres",
  password: "postgres",
  database: "houston_test",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the HoustonDashboard port and ensure we start a server for browser
# testing with hound.
config :houston_dashboard, HoustonDashboard.Endpoint,
  http: [port: 4099],
  server: true

# Configure the HoustonLegacy database
config :houston_legacy, HoustonLegacy.Repo, database: "houston_test"
