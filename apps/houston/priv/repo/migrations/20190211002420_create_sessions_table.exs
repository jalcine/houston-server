defmodule Houston.Repo.Migrations.CreateSessionsTable do
  use Ecto.Migration

  def up do
    create table(:sessions) do
      add :token, :string, null: false
      add :user_id, references(:users), null: false

      timestamps(updated_at: false, type: :utc_datetime)
      add :expires_at, :utc_datetime, null: false
    end

    create unique_index(:sessions, [:token])
    create index(:sessions, :expires_at)
  end

  def down do
    drop table(:sessions)
  end
end
