defmodule Houston.Accounts do
  @moduledoc """
  Handles all user account and session activites.
  """

  use Houston.Context

  alias Houston.Accounts.{Session, User}

  #
  # User
  #

  @doc """
  Attempts to log in a user.
  """
  def login(%User{} = user, password) do
    case check_password(user, password) do
      true -> create_session(user)
      false -> {:error, "Incorrect username or password"}
    end
  end

  def login(username_or_email, password) do
    case get_user(username_or_email) do
      nil -> {:error, "Incorrect username or password"}
      user -> login(user, password)
    end
  end

  @doc """
  Finds a user by the username or email address.
  """
  def get_user(username_or_email) do
    User
    |> User.query_login(username_or_email)
    |> Repo.one()
  end

  def get_user!(username_or_email) do
    User
    |> User.query_login(username_or_email)
    |> Repo.one!()
  end

  @doc """
  Checks a user's password using cryptography sound methods to avoid timing
  attacks.
  """
  def check_password(%User{} = user, given_password),
    do: check_password(user.password, given_password)

  def check_password(password, given_password) when is_binary(given_password),
    do: Plug.Crypto.secure_compare(password, given_password)

  def check_password(password, _), do: false

  #
  # Session
  #

  @doc """
  Creates a new session for a user.
  """
  def create_session(%User{} = user, expires_at \\ nil) do
    user
    |> build_assoc(:session, expires_at: expires_at)
    |> Repo.insert()
  end

  def create_session!(%User{} = user, expires_at \\ nil) do
    user
    |> build_assoc(:session, expires_at: expires_at)
    |> Repo.insert!()
  end
end
