defmodule Houston.Repo.Migrations.UpdateReleaseVersionMeta do
  use Ecto.Migration

  def change do
    alter table(:releases) do
      remove :version_meta
    end
  end
end
