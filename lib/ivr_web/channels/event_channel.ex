defmodule IvrWeb.EventChannel do
  use IvrWeb, :channel

  def join("event:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #  {:reply, {:ok, payload}, socket}
    
  # end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (event:lobby).
  #def handle_in("shout", payload, socket) do
   # broadcast socket, "shout", payload
    #{:noreply, socket}
  #end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end


  def broadcast_change(event) do
  payload = %{
    "time" => event.time,
    "host" => event.host,
    "source" => event.source,
    "sourcetype" => event.sourcetype,
    "index" => event.transcription,
    "transcription" => event.transcription,
    "sipCallID" => event.sipCallID,
    "sipToURI" => event.sipToURI,
    "sipFromURI" => event.sipFromURI,
    "confidence"=> event.confidence,
    "is_session_new?" => event.is_session_new
  }
  IvrWeb.Endpoint.broadcast("event:lobby", "daniel", payload)
  # Process.sleep(10_000)
  # broadcast_change("event")
end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

# defp random_sentences do
#   ["I dont need anything else",
#   "I would love to see this work",
#  "This is just for demostration Purposes",
#  "Joe waited for the train",
#  "The train was late.",
#  "Mary and Samantha took the bus.",
#  "I looked for Mary and Samantha at the bus station",
#  "Mary and Samantha arrived at the bus station early but waited until noon for the bus.",
#  "Joe realized that the train was late while he waited at the train station",
#  "Mary and Samantha realized that Joe was waiting at the train station after they left on the bus",
#  "After supper, Atticus sat down with the paper and called, Scout, ready to read?",
#  "The Lord sent me more than I could bear, and I went to the front porch. Atticus followed me.",
#  "Something wrong, Scout?",
#  "I told Atticus I didn't feel very well and didn't think I'd go to school any more if it was all right with him",
#  "I'm feeling all right, really"]
# end


end
