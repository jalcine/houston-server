defmodule Houston.Repo.Migrations.FixTableIdColumnNames do
  use Ecto.Migration

  def change do
    rename table(:releases), :project, to: :project_id
    rename table(:builds), :release, to: :release_id
    rename table(:packages), :build, to: :build_id
  end
end
