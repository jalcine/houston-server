defmodule HoustonDashboard.Auth.LoginForm do
  use HoustonDashboard, :form

  import Ecto.Changeset

  @schema %{
    username_or_email: :string,
    password: :string
  }

  def new() do
    struct(%{})
  end

  def validate(changeset) do
    changeset
    # |> validate_required([:username_or_email, :password])
    |> validate_length(:password, min: 6)
  end

  def process_params(params) do
    res =
      params
      |> cast()
      |> validate()
      |> apply_action(:insert)

    # TODO: Always return a changeset
    case res do
      {:error, changeset} -> changeset
      {:ok, result} -> result
    end
  end

  def cast(params) do
    data = %{}
    empty_map = Map.keys(@schema) |> Enum.reduce(%{}, fn key, acc -> Map.put(acc, key, nil) end)

    changeset = {data, @schema} |> Ecto.Changeset.cast(params, Map.keys(@schema))

    put_in(changeset.changes, Map.merge(empty_map, changeset.changes))
  end
end
