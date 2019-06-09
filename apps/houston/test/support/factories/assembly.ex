defmodule Houston.AssemblyFactory do
  use ExMachina.Ecto, repo: Houston.Repo

  alias Houston.Assembly.{Build, Package}
  alias Houston.RepositoryFactory

  def build_factory do
    %Build{
      release: RepositoryFactory.build(:release)
    }
  end

  def issue_factory do
  end

  def package_factory do
    %Package{
      build: build(:build),
      filename: sequence(:filename, &"test-package-#{&1}.deb")
    }
  end
end
