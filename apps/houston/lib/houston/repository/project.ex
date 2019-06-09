defmodule Houston.Repository.Project do
  @moduledoc """
  This module represents all projects we know about in our system. They are
  designed to be very agnostic as to what code repository is in use, and what
  service the data is from.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Houston.Repository.{Project, Release}

  schema "projects" do
    field :rdnn, :string
    field :type, :string

    field :service, :string
    field :service_domain, :string
    field :service_metadata, :map

    has_many :releases, Release

    timestamps(type: :utc_datetime)
    field :deleted_at, :utc_datetime
  end

  # TODO: typedoc
  @type t :: %Project{
          id: Ecto.UUID.t(),
          rdnn: String.t(),
          type: String.t(),
          service: String.t(),
          service_domain: String.t(),
          service_metadata: Map.t(),
          releases: Schema.many(Release),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          deleted_at: DateTime.t()
        }

  @required_fields ~w(
    rdnn
    service
    service_domain
  )a

  @optional_fields ~w(
    type
    service_metadata
    deleted_at
  )a

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:releases)
  end
end
