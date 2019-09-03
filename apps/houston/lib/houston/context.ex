defmodule Houston.Context do
  @moduledoc """
  Common logic for top level context files. This includes access to `Ecto.Query`
  and `Ecto.Repo`.
  """

  defmacro __using__(_) do
    quote do
      import Ecto, only: [assoc: 2, build_assoc: 2, build_assoc: 3]
      import Ecto.Query, only: [from: 2]

      alias Houston.Context
      alias Houston.Repo
    end
  end
end
