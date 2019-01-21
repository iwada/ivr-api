
defmodule IvrWeb.UserController do
  use IvrWeb, :controller

  alias Ivr.Accounts
  alias Ivr.Accounts.User
  alias Ivr.Auth.Guardian

  action_fallback(IvrWeb.FallbackController)


  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      new_conn = Guardian.Plug.sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)

      new_conn
      |> put_status(:created)
      |> put_view(IvrWeb.SessionView)
      |> render("show.json", user: user, jwt: jwt)
    end
  end
end