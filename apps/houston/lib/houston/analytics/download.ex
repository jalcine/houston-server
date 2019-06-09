defmodule Houston.Analytics.Download do
  @moduledoc """
  This module is responsible for recording all downloads of a
  `Houston.Assembly.Package` from some source. It uses the power of timescale db
  to make the storage efficent and fast to query.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Houston.Analytics.Download
  alias Houston.Assembly.Package

  schema "downloads" do
    belongs_to :package, Package

    field :timestamp, :utc_datetime
  end

  # TODO: typedoc
  @type t :: %Download{
          id: Ecto.UUID.t(),
          package: Schema.one(Package),
          timestamp: DateTime.t()
        }

  @required_fields ~w(
    timestamp
  )a

  @optional_fields ~w(
  )a

  @doc false
  def changeset(%Download{} = download, attrs) do
    download
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:package)
  end
end
