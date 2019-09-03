# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Houston.Repo.insert!(%Houston.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
# Inside seed files, you you have access to the database factories:
#
#     AccountsFactory.insert(:user, email: "admin@elementary.io")
#

{:ok, _} = Application.ensure_all_started(:ex_machina)

Houston.Repo.transaction(fn ->
  Ecto.Adapters.SQL.query!(Houston.Repo, "SET session_replication_role = 'replica';")

  try do
    __ENV__.file
    |> Path.dirname()
    |> Path.join("seeds/**/*.exs")
    |> Path.wildcard()
    |> Enum.sort()
    |> Enum.each(&Code.eval_file(&1))
  after
    Ecto.Adapters.SQL.query!(Houston.Repo, "SET session_replication_role = 'origin';")
  end
end, [timeout: :infinity])
