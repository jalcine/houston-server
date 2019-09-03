defmodule Houston.Accounts.Session do
  @moduledoc """
  This module represents every session created on the system. They are created
  at every login, and expire after some set amount of time.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Houston.Accounts.{Session, User}

  schema "sessions" do
    field :token, :string

    belongs_to :user, User

    timestamps(updated_at: false, type: :utc_datetime)
    field :expires_at, :utc_datetime
  end

  @typedoc """
  ## Fields

  * `token`: A unique generated token used for session loading.

  * `inserted_at`: The date and time when the token was created.
  * `expires_at`: The date and time when the token will no longer be valid.

  ## Assocations

  * `user`: The user this token belongs to.
  """
  @type t :: %Session{
          id: Ecto.UUID.t(),
          token: Strin.t(),
          user: Schema.one(User),
          inserted_at: DateTime.t(),
          expires_at: DateTime.t()
        }

  @required_fields ~w()a

  @optional_fields ~w()a

  @doc false
  def changeset(%Session{} = session, attrs) do
    session
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:token)
    |> generate_token()
    |> maybe_generate_expires_at()
  end

  @doc """
  Checks if the session has expired before
  """
  def expired?(%Session{} = session),
    do: expired?(session.expires_at)

  def expired?(nil), do: false

  def expired?(%DateTime{} = expires_at),
    do: DateTime.compare(expires_at, DateTime.utc_now()) == :lt

  @doc false
  defp generate_token(%Changeset{} = changeset) do
    case get_field(changeset, :token) do
      nil -> put_change(changeset, :token, generate_token())
      _ -> changeset
    end
  end

  @doc false
  defp generate_token(),
    do: Base.encode16(:crypto.strong_rand_bytes(32), case: :lower)

  @doc false
  defp maybe_generate_expires_at(%Changeset{} = changeset) do
    case get_field(changeset, :expires_at) do
      nil -> put_change(changeset, :expires_at, generate_expires_at())
      _ -> changeset
    end
  end

  @doc false
  defp generate_expires_at() do
    DateTime.utc_now()
    |> DateTime.add(60 * 60 * 24 * 7, :second)
    |> DateTime.truncate(:second)
  end
end
