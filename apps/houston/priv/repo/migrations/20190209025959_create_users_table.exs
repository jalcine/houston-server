defmodule Houston.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false

      add :terms_of_service, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end

  def down do
    drop table(:users)
  end
end
