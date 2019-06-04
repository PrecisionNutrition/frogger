defmodule Frogger do
  require Logger

  @all_roles_url "https://api.glassfrog.com/api/v3/roles"

  def get_roles do
    Logger.info("Requesting all roles...")

    with  {:ok, %Mojito.Response{body: body}}   <- Mojito.request(:get, @all_roles_url, request_headers()),
          {:ok, %{
            "roles" => roles,
            "linked" => %{
              "accountabilities" => accountabilities,
              "circles" => circles,
              "domains" => domains,
              "people" => people
            }
          }}                                    <- Jason.decode(body)
    do
      accountabilities = indexed_by_id(accountabilities)
      circles = indexed_by_id(circles)
      domains = indexed_by_id(domains)
      people = indexed_by_id(people)

      reified_roles = roles
      |> Enum.map(&(reify_role(&1, accountabilities, circles, domains, people)))
      |> Enum.reject(&(&1[:is_core]))

      {:ok, reified_roles}
    else
      err -> {:error, err}
    end
  end

  defp reify_role(
    %{
      "name" => name,
      "purpose" => purpose,
      "is_core" => is_core,
      "links" => %{
        "circle" => circle_id,
        "accountabilities" => accountability_ids,
        "domains" => domain_ids,
        "people" => person_ids
      }
    },
    accountabilities, circles, domains, people
  ) do
    %{
      name: name,
      purpose: purpose,
      is_core: is_core,
      circle: circles[circle_id]["name"],
      domains: lookup(domain_ids, domains, "description"),
      accountabilities: lookup(accountability_ids, accountabilities, "description"),
      people: lookup(person_ids, people, "name")
    }
  end

  defp request_headers, do: [{"X-Auth-Token", api_key()}]
  defp api_key, do: Application.get_env(:frogger, :glassfrog_api_key)
  defp indexed_by_id(list), do: list |> Enum.into(%{}, &({&1["id"], &1}))
  defp lookup(ids, map, field), do: Enum.map(ids, &(map[&1][field]))
end
