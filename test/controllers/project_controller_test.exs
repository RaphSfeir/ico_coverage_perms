defmodule IcoCoveragePerms.ProjectControllerTest do
  use IcoCoveragePerms.ConnCase, async: true
  
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "GET /projects get all projects on index", %{conn: conn} do
    conn = get conn, project_path(conn, :index)
    assert [] = json_response(conn, 200)
  end
end
