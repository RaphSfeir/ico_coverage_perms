defmodule IcoCoveragePerms.Access do
  use Ecto.Schema
  use Dayron.Model

  schema "/access" do
    field :login, :string
    field :password, :string
    field :service_id, :string
  end
end
