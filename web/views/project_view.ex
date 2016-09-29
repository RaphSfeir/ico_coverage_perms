defmodule IcoCoveragePerms.ProjectView do
  use IcoCoveragePerms.Web, :view

  def render("index.json", %{projects: projects}) do
    render_many(projects, IcoCoveragePerms.ProjectView, "project.json")
  end 

  def render("show.json", %{project: project}) do
    render_one(project, IcoCoveragePerms.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
     %{
       name: project.name
     }
  end
end
