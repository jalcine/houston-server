defmodule Houston.RepositoryFactory do
  use ExMachina.Ecto, repo: Houston.Repo

  alias Houston.Repository.{Project, Release}

  def project_factory do
    %Project{
      rdnn: sequence(:rdnn, &"com.github.elementary.houston-test-#{&1}"),
      type: "application",
      service: "github",
      service_domain: "github.com",
      service_metadata: %{
        id: sequence(:id),
        owner: "elementary",
        repo: sequence(:repo, &"houston-test-#{&1}"),
        installation: sequence(:service_installation)
      }
    }
  end

  def release_factory do
    %Release{
      project: build(:project),
      version: sequence(:version, &"1.0.#{&1}"),
      version_major: 1,
      version_minor: 0,
      version_patch: sequence(:patch),
      version_development: false,
      service_metadata: %{
        id: sequence(:id)
      }
    }
  end
end
