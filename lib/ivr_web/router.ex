defmodule IvrWeb.Router do
  use IvrWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug(Ivr.Auth.Pipeline)
  end

  scope "/api/v1", IvrWeb do
    pipe_through :api

    post("/sessions", SessionController, :create)
    post("/users", UserController, :create)
  end

   scope "/api/v1", IvrWeb do
    pipe_through([:api, :api_auth])

    delete("/sessions", SessionController, :delete)
    post("/sessions/refresh", SessionController, :refresh)
  end


end
