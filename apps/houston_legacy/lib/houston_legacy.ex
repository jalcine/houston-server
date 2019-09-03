defmodule HoustonLegacy do
  @moduledoc """
  HoustonLegacy handles logic between our current JavaScript application and
  our new Elixir application.
  """

  import Ecto.Query

  alias Houston.Repository.Project

  @doc """
  Syncs all known old legacy projects.
  """
  def sync_all!() do
    HoustonLegacy.Repo
    |> Mongo.find("projects", %{})
    |> Enum.to_list()
    |> Enum.map(& &1["name"])
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.each(&sync!/1)
  end

  @doc """
  Syncs a list of legacy projects to our new database.
  """
  def sync!(rdnn) do
    legacy_project =
      HoustonLegacy.Repo
      |> Mongo.find("projects", %{name: rdnn})
      |> Enum.to_list()
      |> hd()

    legacy_builds =
      HoustonLegacy.Repo
      |> Mongo.find("cycles", %{name: %{in: rdnn}})
      |> Enum.to_list()

    project =
      case get_project(rdnn) do
        {:ok, project} -> project
        nil -> %Project{}
      end

    upsert_project!(project, legacy_project, legacy_builds)
  end

  defp get_project(rdnn) do
    Project
    |> where([p], p.rdnn == ^rdnn)
    |> first()
    |> Houston.Repo.one()
  end

  defp upsert_project!(project, legacy_project, legacy_builds) do
    casted_project = cast_project(legacy_project, legacy_builds)

    changeset =
      project
      |> Houston.Repository.Project.changeset(casted_project)

    if project.id != nil do
      Houston.Repo.update!(changeset)
    else
      Houston.Repo.insert!(changeset)
    end
  end

  defp cast_project(legacy_project, legacy_builds) do
    builds =
      Enum.filter(legacy_builds, fn b ->
        b["name"] === legacy_project["name"]
      end)

    casted_releases =
      legacy_project["releases"]
      |> Enum.map(&cast_release(&1, builds))
      |> Enum.sort(&(Version.compare(&1.version, &2.version) != :lt))

    %{
      rdnn: legacy_project["name"],
      type: "application",
      service: "github",
      service_domain: "github.com",
      service_metadata: %{
        github_id: get_in(legacy_project, ["github", "id"]),
        github_installation: get_in(legacy_project, ["github", "installation"]),
        github_name: get_in(legacy_project, ["github", "name"]),
        github_owner: get_in(legacy_project, ["github", "owner"])
      },
      releases: casted_releases
    }
  end

  defp cast_release(legacy_release, legacy_builds) do
    version = Version.parse!(legacy_release["version"])
    tag = get_in(legacy_release, ["github", "tag"])

    casted_builds =
      legacy_builds
      |> Enum.filter(&(&1["tag"] == tag))
      |> Enum.map(&cast_builds(&1, version))

    %{
      builds: casted_builds,
      version: legacy_release["version"],
      version_major: version.major,
      version_minor: version.minor,
      version_patch: version.patch,
      version_development: false,
      service_metadata: %{
        github_id: get_in(legacy_release, ["github", "id"]),
        github_tag: tag
      }
    }
  end

  defp cast_builds(legacy_builds, version) do
    packages =
      legacy_builds["packages"]
      |> Enum.filter(&String.contains?(&1, to_string(version)))
      |> Enum.map(&cast_packages/1)

    %{packages: packages}
  end

  defp cast_packages(legacy_package) do
    %{
      service: "aptly",
      service_metadata: %{
        aptly_key: legacy_package
      }
    }
  end
end
