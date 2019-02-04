defmodule IvrWeb.Router do
  use IvrWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug(Ivr.Auth.Pipeline)
  end


   scope "/api/v1", IvrWeb do
    pipe_through([:api, :api_auth])

    delete("/sessions", SessionController, :delete)
    post("/sessions/refresh", SessionController, :refresh)
    resources("/dids", InwardDialController, except: [:new, :edit])
    get("/events/sip_call_ids", EventController, :index)
  end


  scope "/api/v1", IvrWeb do
    pipe_through :api

    post("/sessions", SessionController, :create)
    post("/users", UserController, :create)
    resources("/events", EventController, except: [:new, :edit,:index])
  end


end
