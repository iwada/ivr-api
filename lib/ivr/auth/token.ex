defmodule Ivr.Auth.Token do
  @moduledoc """
  Handles creating and validating tokens.
  """
  alias Ivr.Accounts.User
  @account_verification_salt "account verification salt"

  def generate_new_account_token(%User{id: user_id}) do
    Phoenix.Token.sign(IvrWeb.Endpoint, @account_verification_salt, user_id)
  end


   def verify_new_account_token(token) do
    max_age = 86_400 # tokens that are older than a day should be invalid
    Phoenix.Token.verify(IvrWeb.Endpoint, @account_verification_salt, token, max_age: max_age)
  end
  
end