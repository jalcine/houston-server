defmodule Houston.Repo.Migrations.CreateProjectsTable do
  use Ecto.Migration

  def up do
    create table(:projects) do
      add :rdnn, :string, null: false
      add :type, :string, default: "application"

      add :service, :string, null: false
      add :service_api, :string, null: false
      add :service_metadata, :map, default: %{}
      add :service_repo, :map, default: %{}

      timestamps(type: :utc_datetime)
      add :deleted_at, :utc_datetime
    end

    create unique_index(:projects, [:rdnn])
  end

  def down do
    drop table(:projects)
  end
end
