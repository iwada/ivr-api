defmodule Ivr.Auth.Guardian do
  use Guardian, otp_app: :ivr

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    case Ivr.Accounts.get_user(claims["sub"]) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end