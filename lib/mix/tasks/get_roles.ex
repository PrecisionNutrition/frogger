defmodule Mix.Tasks.Roles do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Mix.Task.run "app.start"
    Logger.configure(level: :error)

    {:ok, roles} = Frogger.get_roles()

    roles
    |> Enum.map(&format_role/1)
    |> Enum.each(&IO.puts/1)
  end

  defp format_role(role) do
    """
    ---------------------------------------------------------------------------
    Role: #{role[:name]} in #{role[:circle]}

    Purpose: #{role[:purpose]}

    Domains:
    #{role[:domains] |> Enum.join("\n")}

    Accountabilities:
    #{role[:accountabilities] |> Enum.join("\n")}

    Holders: #{role[:people] |> Enum.join(", ")}

    """
  end
end
