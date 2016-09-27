defmodule IcoCoveragePerms.AccessControllerTest do
  
  use IcoCoveragePerms.ConnCase

  alias IcoCoveragePerms.KongRepo
  alias IcoCoveragePerms.Access

  @valid_attrs %{ login: "phoenix_test_user", name: "phoenix_test_user", password_hash: "Sdspsdo921kOp1LoiJK3j2_39", password: "S3cr3t_Dud3", service_id: "test"}
  @invalid_attrs %{ login: "1", password: "1234", service_id: "aa" }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    #conn = post conn, access_path(conn, :create), login: @valid_attrs
    #assert json_response(conn, 201)["data"]["access_token"]
  end

  test "gets forbidden status when credentials aren't valid", %{conn: conn} do
    #conn = post conn, access_path(conn, :create), login: @invalid_attrs
    #assert json_response(conn, 401)["errors"]["detail"]
  end

end
