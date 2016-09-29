defmodule IcoCoveragePerms.ProjectController do
  use IcoCoveragePerms.Web, :controller

  alias IcoCoveragePerms.Project

  def index(conn, _params) do
    conn
      |> render("index.json", projects: Repo.all(Project))
  end
end
