defmodule IvrWeb.FallbackController do
  use IvrWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(IvrWeb.ErrorView)
    |> render(:"422")
  end
end


