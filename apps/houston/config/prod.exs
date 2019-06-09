# Since configuration is shared in umbrella projects, this file
# should only configure the :houston application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :houston, Houston.Repo,
  username: "postgres",
  password: "postgres",
  database: "houston_prod",
  hostname: "localhost",
  pool_size: 15
