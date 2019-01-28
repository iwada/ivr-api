defmodule IvrWeb.UserView do
  use IvrWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end


   def render("test_dump.json",_) do
    %{
      
    }
  end
end