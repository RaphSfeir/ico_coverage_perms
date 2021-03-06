defmodule IcoCoveragePerms.Project do
  use IcoCoveragePerms.Web, :model
  
  schema "projects" do
    field :name, :string
    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the model
  If no params are provided, an invalid changeset is returned
  with no validation performed
  """
  def changeset(model, params \\ :empty) do
    model
      |> cast(params, @required_fields, @optional_fields)
      |> validate_length(:name, min: 3)
  end
end
