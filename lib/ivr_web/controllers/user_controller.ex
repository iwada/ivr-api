
defmodule IvrWeb.UserController do
  use IvrWeb, :controller

  alias Ivr.Accounts
  alias Ivr.Accounts.User
  alias Ivr.Auth.Guardian
  alias Ivr.Notifications
  alias Ivr.Mailer

  action_fallback(IvrWeb.FallbackController)

  
  
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      new_conn = Guardian.Plug.sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)
      token = Ivr.Auth.Token.generate_new_account_token(user)
      verification_url = Routes.user_url(conn, :verify_email, token: token)
     # IEx.pry
     Task.start(fn -> Ivr.Notifications.send_account_verification_email(user, verification_url) |> Mailer.deliver end)

      new_conn
      |> put_status(:created)
      |> put_view(IvrWeb.SessionView)
      |> render("show.json", user: user, jwt: jwt)
    end
  end


  #  def verify_email(conn, params) do
  #   # We'll update this later
  # end


  def verify_email(conn, %{"token" => token}) do
    with {:ok, user_id} <- Ivr.Auth.Token.verify_new_account_token(token),
         {:ok, %User{verified: false} = user} <- Accounts.user_verification_status(user_id) do
        #  IEx.pry
      Accounts.mark_as_verified(user)
      conn
      |> put_status(:created)
      |> put_view(IvrWeb.UserView)
      |> render("verified.json")
    else
      _ -> 
         conn
      |> put_status(:created)
      |> put_view(IvrWeb.UserView)
      |> render("not_verified.json")
    end
  end
end