defmodule IcoCoveragePerms.AccessManager do
  use IcoCoveragePerms.Web, :controller

  def login(conn, params) do
    case Access.find_and_confirm_password(params) do
      {:ok, token} ->
        new_conn = Guardian.Plug.api_sign_in(conn, token)
        jwt = Guardian.Plug.current_token(new_conn)
        claims = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", exp)
        |> render "login.json", user: token, jwt: jwt, exp: exp
      {:error, changeset} ->
        conn
        |> put_status(401)
        |> render "error.json", message: "Could not login" 
    end
  end
end
