defmodule Houston.Repo do
  use Ecto.Repo,
    otp_app: :houston,
    adapter: Ecto.Adapters.Postgres
end
