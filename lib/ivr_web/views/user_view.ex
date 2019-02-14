defmodule IvrWeb.UserView do
  use IvrWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end


   def render("verified.json",_) do
    %{
      
    }
  end

  def render("not_verified.json",_) do
    %{
      error: "Already Verified / Verification Code Expired"
    }
  end
end