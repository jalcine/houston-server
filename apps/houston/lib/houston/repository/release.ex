defmodule Houston.Repository.Release do
  @moduledoc """
  This module represents all created releases for a project.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Houston.Assembly.Build
  alias Houston.Repository.{Project, Release}

  schema "releases" do
    belongs_to :project, Project
    has_many :builds, Build

    field :version, :string
    field :version_major, :integer
    field :version_minor, :integer
    field :version_patch, :integer
    field :version_development, :boolean

    field :service_metadata, :map

    timestamps(type: :utc_datetime)
    field :deleted_at, :utc_datetime
  end

  # TODO: typedoc
  @type t :: %Release{
          id: Ecto.UUID.t(),
          project: Schema.one(Project),
          builds: Schema.many(Build),
          version: String.t(),
          version_major: Version.major(),
          version_minor: Version.minor(),
          version_patch: Version.patch(),
          version_development: Boolean.t(),
          service_metadata: Map.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          deleted_at: DateTime.t()
        }

  @required_fields ~w(
    version
    version_major
    version_minor
    version_patch
  )a

  @optional_fields ~w(
    version_development

    service_metadata

    deleted_at
  )a

  @doc false
  def changeset(%Release{} = release, attrs) do
    release
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:project)
  end
end
