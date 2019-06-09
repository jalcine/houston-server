defmodule HoustonLegacyTest do
  use HoustonLegacy.DataCase

  alias HoustonLegacy

  describe "list_projects/0" do
    test "sync!/1 will add a new project" do
      HoustonLegacy.sync!("com.github.elementary.debian-test-package")
      assert Houston.Repo.all(Houston.Repository.Project) |> length() == 1
    end
  end
end
