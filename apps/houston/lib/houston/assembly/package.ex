defmodule Houston.Assembly.Package do
  @moduledoc """
  This represents every package created from a build. This is general enough to
  handle different package types.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Houston.Assembly.{Build, Package}
  alias Houston.Repository.{Project, Release}

  schema "packages" do
    belongs_to :build, Build
    has_one :release, through: [:build, :release]
    has_one :project, through: [:release, :project]

    field :filename, :string

    field :service, :string
    field :service_metadata, :map

    timestamps(type: :utc_datetime)
    field :published_at, :utc_datetime
  end

  # TODO: typedoc
  @type t :: %Package{
          id: Ecto.UUID.t(),
          build: Schema.one(Build),
          release: Schema.one(Release),
          project: Schema.one(Project),
          filename: String.t(),
          service: String.t(),
          service_metadata: Map.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          published_at: DateTime.t()
        }

  @required_fields ~w(
    filename
    service
  )a

  @optional_fields ~w(
    service_metadata
  )a

  @doc false
  def changeset(%Package{} = package, attrs) do
    package
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:build)
  end
end
