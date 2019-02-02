defmodule IvrWeb.EventView do
  use IvrWeb, :view
  alias IvrWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      time: event.time,
      host: event.host,
      source: event.source,
      transcription: event.transcription,
      sipcallid: event.sipCallID,
      confidence: event.confidence,
      index: event.index}
  end
end
