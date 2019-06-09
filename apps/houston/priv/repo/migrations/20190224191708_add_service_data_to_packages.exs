defmodule Houston.Repo.Migrations.AddServiceDataToPackages do
  use Ecto.Migration

  def change do
    alter table(:packages) do
      add :service, :string, null: false
      add :service_metadata, :map, default: %{}
    end
  end
end
