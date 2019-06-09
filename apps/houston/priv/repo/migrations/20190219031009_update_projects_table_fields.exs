defmodule Houston.Repo.Migrations.UpdateProjectsTableFields do
  use Ecto.Migration

  def change do
    rename table(:projects), :service_api, to: :service_domain

    alter table(:projects) do
      remove :service_repo
    end
  end
end
