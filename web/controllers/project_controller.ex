defmodule IcoCoveragePerms.ProjectController do
  use IcoCoveragePerms.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated

  alias IcoCoveragePerms.Project

  def index(conn, _params) do
    conn
      |> render("index.json", projects: Repo.all(Project))
  end
end
