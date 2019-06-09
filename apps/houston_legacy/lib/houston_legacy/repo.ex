defmodule HoustonLegacy.Repo do
  use Mongo.Pool, name: __MODULE__, adapter: Mongo.Pool.Poolboy
end
