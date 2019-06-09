defmodule Houston.AccountsFactory do
  use ExMachina.Ecto, repo: Houston.Repo

  alias Houston.Accounts.{Session, User}

  def role_factory do
  end

  def session_factory do
    %Session{
      token: "test token",
      user: build(:user),
      expires_at: NaiveDateTime.utc_now() |> NaiveDateTime.add(3600)
    }
  end

  def user_factory do
    %User{
      username: sequence(:username, &"user #{&1}"),
      email: sequence(:email, &"user#{&1}@example.com")
    }
  end
end
