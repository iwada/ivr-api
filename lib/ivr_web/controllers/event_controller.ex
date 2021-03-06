defmodule IvrWeb.EventController do
  use IvrWeb, :controller

  alias Ivr.Telephony
  alias Ivr.Telephony.Event
  require IEx
  action_fallback IvrWeb.FallbackController

  def index(conn, _params) do
   current_user =  Guardian.Plug.current_resource(conn)
    events = Telephony.list_events(current_user)
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
   sipToURI =  event_params["sipToURI"] || ""
   sipCallID = event_params["sipCallID"] || ""
   striped_sipcallid  = String.replace(sipCallID, "sip:", "") |> String.split("@") |> hd || ""
   provisioned_did = String.replace(sipToURI, "sip:", "") |> String.split("@") |> hd || ""
    event_owner = Telephony.get_provisioned_did_owner(provisioned_did)
    new_event_params = Map.merge(event_params, %{
        "host" => conn.params["host"],
        "index" => conn.params["index"],
        "source" => conn.params["source"],
        "sourcetype" => conn.params["sourcetype"],
        "time" => conn.params["time"],
       # "is_session_new" => !Telephony.is_session_new?(event_params["sipCallID"]),
        "is_session_new" => !Telephony.is_session_new?(striped_sipcallid),
        "sipCallID" => striped_sipcallid
      })
     # if !Telephony.is_session_new?(event_params["sipCallID"]), do: IvrWeb.EventChannel.broadcast_sipCallID(event_params["sipCallID"],
      if !Telephony.is_session_new?(striped_sipcallid), do: IvrWeb.EventChannel.broadcast_sipCallID(striped_sipcallid,
        conn.params["host"],event_params["sipToURI"],event_params["sipFromURI"])
      with {:ok, %Event{} = event} <- Telephony.create_event(new_event_params, event_owner) do
     
      # There's a Possiblity of using GenEvent for this. TODO
      #IEx.pry
      #if !Telephony.is_session_new?(event_params["sipCallID"]), do: IvrWeb.EventChannel.broadcast_sipCallID(event)
      IvrWeb.EventChannel.broadcast_change(event)
      #IEx.pry
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Telephony.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Telephony.get_event!(id)
    with {:ok, %Event{} = event} <- Telephony.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Telephony.get_event!(id)
    with {:ok, %Event{}} <- Telephony.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
