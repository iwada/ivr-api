defmodule Ivr.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :ivr,
    module: Ivr.Auth.Guardian,
    error_handler: Ivr.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end