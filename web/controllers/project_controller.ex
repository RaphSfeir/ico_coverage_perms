defmodule IcoCoveragePerms.ProjectController do
  use IcoCoveragePerms.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  alias IcoCoveragePerms.Project

  def index(conn, _params) do
    conn
      |> render("index.json", projects: Repo.all(Project))
  end

  def unauthenticated(conn, _params) do
    conn
      |> put_status(:unauthorized)
      |> render(IcoCoveragePerms.ErrorView, "401.json")
  end
end
