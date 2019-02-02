defmodule IvrWeb.InwardDialController do
  use IvrWeb, :controller

  alias Ivr.Telephony
  alias Ivr.Telephony.InwardDial
  require IEx
  action_fallback IvrWeb.FallbackController

  def index(conn, _params) do
    inwarddials = Telephony.list_inwarddials()
    render(conn, "index.json", inwarddials: inwarddials)
  end

  def create(conn, %{"inward_dial" => inward_dial_params}) do
    current_user = Guardian.Plug.current_resource(conn)
    with {:ok, %InwardDial{} = inward_dial} <- Telephony.create_inward_dial(inward_dial_params, current_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.inward_dial_path(conn, :show, inward_dial))
      |> render("show.json", inward_dial: inward_dial)
    end
  end

  def show(conn, %{"id" => id}) do
    inward_dial = Telephony.get_inward_dial!(id)
    render(conn, "show.json", inward_dial: inward_dial)
  end

  def update(conn, %{"id" => id, "inward_dial" => inward_dial_params}) do
    inward_dial = Telephony.get_inward_dial!(id)

    with {:ok, %InwardDial{} = inward_dial} <- Telephony.update_inward_dial(inward_dial, inward_dial_params) do
      render(conn, "show.json", inward_dial: inward_dial)
    end
  end

  def delete(conn, %{"id" => id}) do
    inward_dial = Telephony.get_inward_dial!(id)

    with {:ok, %InwardDial{}} <- Telephony.delete_inward_dial(inward_dial) do
      send_resp(conn, :no_content, "")
    end
  end
end
