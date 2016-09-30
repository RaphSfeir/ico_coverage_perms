defmodule IcoCoveragePerms.Access do
  def __from_json__(%{data: data}, opts) do
    data
  end

  use Ecto.Schema
  use Dayron.Model

  schema "access" do
    field :login, :string
    field :password, :string
    field :service_id, :string
    field :token_type,  :string
    field :refresh_token, :string
    field :expires_in, :integer
    field :access_token, :string
  end
end
