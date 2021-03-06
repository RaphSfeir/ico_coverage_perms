defmodule IcoCoveragePerms.AccessControllerTest do
  
  use IcoCoveragePerms.ConnCase

  @valid_attrs %{ login: "Raphael234", password: "testtest", service_id: "django-services-todos"}
  @invalid_attrs %{ login: "1", password: "1234", service_id: "aa" }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, access_path(conn, :create), login: @valid_attrs
    assert json_response(conn, 201)["data"]["access_token"]
  end

  test "gets forbidden status when credentials aren't valid", %{conn: conn} do
    conn = post conn, access_path(conn, :create), login: @invalid_attrs
    assert json_response(conn, 403)["errors"]["detail"]
  end

end
