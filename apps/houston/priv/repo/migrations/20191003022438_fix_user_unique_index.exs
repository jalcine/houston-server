defmodule Houston.Repo.Migrations.FixUserUniqueIndex do
  use Ecto.Migration

  def change do
    drop unique_index(:users, [:username, :email])

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
