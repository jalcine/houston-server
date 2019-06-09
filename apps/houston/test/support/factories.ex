defmodule Houston.Factories do
  @moduledoc """
  This module will alias all available factories from `Houston`.
  """

  defmacro __using__(_) do
    quote do
      alias Houston.AccountsFactory
      alias Houston.AssemblyFactory
      alias Houston.RepositoryFactory
    end
  end
end
