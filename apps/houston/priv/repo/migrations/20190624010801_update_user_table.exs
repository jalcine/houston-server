defmodule Houston.Repo.Migrations.UpdateUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string
    end

    drop unique_index(:users, [:username])
    drop unique_index(:users, [:email])

    create unique_index(:users, [:username, :email])
  end
end
