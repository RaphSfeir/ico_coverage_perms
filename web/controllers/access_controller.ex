defmodule IcoCoveragePerms.AccessController do
  use IcoCoveragePerms.Web, :controller

  alias IcoCoveragePerms.Access
  alias IcoCoveragePerms.UManRepo
  
  plug :scrub_params, "login" when action in [:create]

  def create(conn, params = %{"login" => %{"login" => login, "password" => password, "service_id" => service_id}}) do
    case UManRepo.insert(Access, params, [{:hackney, [insecure: true]}]) do
      {:ok, token} -> 
        conn 
          |> put_status(:created)
          |> render("show.json", access: token)
      {:error, error} ->
        conn
          |> put_status(:forbidden)
          |> render(IcoCoveragePerms.ErrorView, "403.json")
    end
  end
end
