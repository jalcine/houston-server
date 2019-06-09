defmodule Houston.Accounts.User do
  @moduledoc """
  This module represents every type of user that could log into our system.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Houston.Accounts.User

  @terms_of_service_date DateTime.from_naive!(~N[2017-05-26 00:00:00], "Etc/UTC")

  schema "users" do
    field :username, :string
    field :email, :string

    field :terms_of_service, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @typedoc """
  ## Fields

  * `username`: A unique human readable string value to identify the user.
  * `email`: A contact email for the user.

  * `terms_of_service`: A date time value of when the user accepted the terms of
    service. We can use this prompt another agreement if we ever update it.

  * `inserted_at`: The date and time when the user was first created.
  * `updated_at`: The date and time when the user was last updated.
  """
  @type t :: %User{
          id: Ecto.UUID.t(),
          username: String.t(),
          email: String.t(),
          terms_of_service: DateTime.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @required_fields ~w(
    username
    email
  )a

  @optional_fields ~w(
    terms_of_service
  )a

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  @doc """
  Checks if the user has agreed to the terms of service yet.
  """
  def viewed_terms_of_service?(%User{} = user),
    do: viewed_terms_of_service?(user.terms_of_service)

  def viewed_terms_of_service?(nil), do: false

  def viewed_terms_of_service?(%DateTime{} = datetime),
    do: DateTime.compare(datetime, @terms_of_service_date) == :gt

  @doc """
  Sets the user to have viewed the terms of service.
  """
  def viewed_terms_of_service(%Ecto.Changeset{} = changeset),
    do: put_change(changeset, :terms_of_service, @terms_of_service_date)
end
