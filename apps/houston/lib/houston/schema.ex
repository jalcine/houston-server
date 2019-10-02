defmodule Houston.Schema do
  @moduledoc """
  Common logic for schema files. This includes `Ecto.Query` helpers and some
  common types.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

      alias Houston.Schema
      alias Houston.Types

      @timestamps_opts [type: :utc_datetime, usec: false]
    end
  end

  @typedoc """
  Standard database ID type.
  """
  @type id :: nil | Ecto.UUID

  @typedoc """
  A single (possibly unloaded) `Ecto.Association`.
  """
  @type one(schema) :: %Ecto.Association.NotLoaded{} | nil | schema

  @typedoc """
  Multiple `Ecto.Assocation`s.
  """
  @type many(schema) :: %Ecto.Association.NotLoaded{} | [schema]
end
