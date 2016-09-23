defmodule IcoCoveragePerms.Router do
  use IcoCoveragePerms.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IcoCoveragePerms do
    pipe_through :api
  end
end
