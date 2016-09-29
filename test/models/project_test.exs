defmodule IcoCoveragePerms.ProjectTest do
  use IcoCoveragePerms.ModelCase

  alias IcoCoveragePerms.Project

  @valid_attrs %{ name: "Project Zero Mission" }
  @invalid_attrs %{ name: "1" }

  test "changeset with valid attributes" do
    changeset = Project.changeset(%Project{}, @valid_attrs)
    assert changeset.valid?
  end 

  test "changeset with invalid attributes" do
    changeset = Project.changeset(%Project{}, @invalid_attrs)
    refute changeset.valid?
  end

end
