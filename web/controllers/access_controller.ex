defmodule IcoCoveragePerms.AccessController do
  use IcoCoveragePerms.Web, :controller

  alias IcoCoveragePerms.Access
  alias IcoCoveragePerms.UManRepo
  
  plug :scrub_params, "login" when action in [:create]

  def create(conn, params = %{"login" => %{"login" => login, "password" => password, "service_id" => service_id}}) do
    case UManRepo.insert(Access, params, [{:hackney, [insecure: true]}]) do
      {:ok, token} -> 
        logged_conn = Guardian.Plug.api_sign_in(conn, token) 
        local_token = Guardian.Plug.current_token(logged_conn)
        {:ok, claims} = Guardian.Plug.claims(logged_conn)
        exp = Map.get(claims, "exp")
        logged_conn
          |> put_resp_header("authorization", "#{token.access_token}")
          |> put_resp_header("local-authorization", "Bearer #{local_token}")
          |> put_resp_header("local-expires", "#{exp}")
          |> put_resp_header("x-expires", "#{token.expires_in}")
          |> put_status(:created)
          |> render("show.json", access: token)
      {:error, error} ->
        conn
          |> put_status(:forbidden)
          |> render(IcoCoveragePerms.ErrorView, "403.json")
    end
  end
end
