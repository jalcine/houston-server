defmodule Houston.Assembly.Build do
  @moduledoc """
  This represents every build we have ran on our infrastructure.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Houston.Assembly.{Build, Package}
  alias Houston.Repository.{Project, Release}

  schema "builds" do
    belongs_to :release, Release
    has_one :project, through: [:release, :project]
    has_many :packages, Package

    timestamps(type: :utc_datetime)
    field :completed_at, :utc_datetime
  end

  # TODO: typedoc
  @type t :: %Build{
          id: Ecto.UUID.t(),
          release: Schema.one(Release),
          project: Schema.one(Project),
          packages: Schema.many(Package),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          completed_at: DateTime.t()
        }

  @required_fields ~w(
  )a

  @optional_fields ~w(
  )a

  @doc false
  def changeset(%Build{} = build, attrs) do
    build
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:release)
  end
end
