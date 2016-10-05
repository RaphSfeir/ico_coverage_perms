defmodule IcoCoveragePerms.Router do
  use IcoCoveragePerms.Web, :router

  pipeline :api do

    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug :accepts, ["json"]
  end

  scope "/api", IcoCoveragePerms do
    pipe_through :api_auth

    resources "/login", AccessController, only: [:create, :show]
    resources "/projects", ProjectController, only: [:index]
  end
end
