defmodule Ivr.Repo do
  use Ecto.Repo,
    otp_app: :ivr,
    adapter: Ecto.Adapters.Postgres
end
