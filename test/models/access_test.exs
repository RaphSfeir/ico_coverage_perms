defmodule IcoCoveragePerms.AccessTest do
  use IcoCoveragePerms.ModelCase

  alias IcoCoveragePerms.Access

  test "defines an access struct" do
    access = struct(Access, %{login: "phoenix_test", password: "S3cr3t_Dud3", service_id: "abcd"})
    assert access.login     == "phoenix_test"
    assert access.password  == "S3cr3t_Dud3"
  end

end
