defmodule Houston.Repo.Migrations.CreatePackagesTable do
  use Ecto.Migration

  def up do
    create table(:packages) do
      add :build, references(:builds), null: false

      add :filename, :string, null: false

      timestamps(type: :utc_datetime)
      add :published_at, :utc_datetime
    end

    create unique_index(:packages, [:filename])
  end

  def down do
    drop table(:packages)
  end
end
