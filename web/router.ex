defmodule IcoCoveragePerms.Router do
  use IcoCoveragePerms.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", IcoCoveragePerms do
    pipe_through :api

    resources "/login", AccessController, only: [:create, :show]
  end
end
