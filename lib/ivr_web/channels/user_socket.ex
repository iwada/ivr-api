defmodule IvrWeb.UserSocket do
  use Phoenix.Socket
  require IEx
  ## Channels
  #channel "room:*", IvrWeb.RoomChannel
  channel "event:*", IvrWeb.EventChannel


  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  # def connect(_params, socket, _connect_info) do
  #   {:ok, socket}
  # end
  def connect(%{"token" => token}, socket) do
    case Guardian.Phoenix.Socket.authenticate(socket, Ivr.Auth.Guardian, token) do
      {:ok, authed_socket} ->  {:ok, authed_socket}
        #IEx.pry
      {:error, _} -> :error
    end
  end

  # This function will be called when there was no authentication information
  def connect(_params, _socket) do
    :error
  end
  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     IvrWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
