defmodule Houston.Repo.Migrations.CreateBuildsTable do
  use Ecto.Migration

  def up do
    create table(:builds) do
      add :release, references(:releases), null: false

      timestamps(type: :utc_datetime)
      add :completed_at, :utc_datetime
    end
  end

  def down do
    drop table(:builds)
  end
end
