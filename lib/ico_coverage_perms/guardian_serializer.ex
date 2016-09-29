defmodule IcoCoveragePerms.GuardianSerializer do
  def for_token(token) do
    {:ok, "Token: #{token.access_token}"}
  end

  def from_token("Token: " <> access_token), do: { :ok, access_token}
  def from_token(_), do: { :error, "Uknown resource type" }
end
