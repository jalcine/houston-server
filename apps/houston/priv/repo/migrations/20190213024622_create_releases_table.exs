defmodule Houston.Repo.Migrations.CreateReleasesTable do
  use Ecto.Migration

  def up do
    create table(:releases) do
      add :project, references(:projects), null: false

      add :version, :string, null: false
      add :version_major, :integer
      add :version_minor, :integer
      add :version_patch, :integer
      add :version_meta, :string
      add :version_development, :boolean

      add :service_metadata, :map, default: %{}

      timestamps(type: :utc_datetime)
      add :deleted_at, :utc_datetime
    end

    create index(:releases, [:version_major, :version_minor, :version_patch])
  end

  def down do
    drop table(:releases)
  end
end
