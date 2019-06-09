defmodule Houston.Repo.Migrations.UpdatePackageTableIndexes do
  use Ecto.Migration

  def up do
    drop unique_index(:packages, [:filename])
  end

  def down do
    create unique_index(:packages, [:filename])
  end
end
