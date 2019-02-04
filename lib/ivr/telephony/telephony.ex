defmodule Ivr.Telephony do
  @moduledoc """
  The Telephony context.
  """

  import Ecto.Query, warn: false
  import Ecto
  alias Ivr.Repo

  alias Ivr.Telephony.Event


  defp user_events(user) do
    assoc(user, :events)  
  end

  def list_events(user) do
    #Repo.all(user_events(user)) 
    target_records =  from(r in Ivr.Telephony.Event, where: r.user_id == ^user.id ,  distinct: r.sipCallID) |> Repo.all

  end

  # def get_event_by(sipCallID) do
  #   target_records =  from(r in Ivr.Telephony.Event, where: r.sipCallID == ^sipCallID )
  #   target_records |> Ecto.Query.first |> Repo.one
  # end

    def get_event_by(sipCallID) do
    target_records =  from(r in Ivr.Telephony.Event, where: r.sipCallID == ^sipCallID )
    target_records |> Repo.all
    end
  

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)
  def get_event_user(id), do: Repo.get(Event, id) |> Repo.preload(:user)
    
  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}, user) do
    %Event{}
    user
    |> Ecto.build_assoc(:events)
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  alias Ivr.Telephony.InwardDial

  @doc """
  Returns the list of inwarddials.

  ## Examples

      iex> list_inwarddials()
      [%InwardDial{}, ...]

  """
  def list_inwarddials do
    Repo.all(InwardDial)
  end

  @doc """
  Gets a single inward_dial.

  Raises `Ecto.NoResultsError` if the Inward dial does not exist.

  ## Examples

      iex> get_inward_dial!(123)
      %InwardDial{}

      iex> get_inward_dial!(456)
      ** (Ecto.NoResultsError)

  """
  def get_inward_dial!(id), do: Repo.get!(InwardDial, id)

  @doc """
  Creates a inward_dial.

  ## Examples

      iex> create_inward_dial(%{field: value})
      {:ok, %InwardDial{}}

      iex> create_inward_dial(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inward_dial(attrs \\ %{}, user) do
    %InwardDial{}
    user
    |> Ecto.build_assoc(:inwarddials)
    |> InwardDial.changeset(attrs)
    |> Repo.insert()
  end
  @doc """
  Updates a inward_dial.

  ## Examples

      iex> update_inward_dial(inward_dial, %{field: new_value})
      {:ok, %InwardDial{}}

      iex> update_inward_dial(inward_dial, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inward_dial(%InwardDial{} = inward_dial, attrs) do
    inward_dial
    |> InwardDial.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a InwardDial.

  ## Examples

      iex> delete_inward_dial(inward_dial)
      {:ok, %InwardDial{}}

      iex> delete_inward_dial(inward_dial)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inward_dial(%InwardDial{} = inward_dial) do
    Repo.delete(inward_dial)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inward_dial changes.

  ## Examples

      iex> change_inward_dial(inward_dial)
      %Ecto.Changeset{source: %InwardDial{}}

  """
  def change_inward_dial(%InwardDial{} = inward_dial) do
    InwardDial.changeset(inward_dial, %{})
  end

  #Get event_provisioned_did
  def get_provisioned_did_owner(direct_inward_dial_number) do
     if result = Repo.get_by(InwardDial, direct_inward_dial_number: direct_inward_dial_number) |> Repo.preload(:user)  do 
        result.user
     else
      "" ###TODO We need to default this to maybe an admin user
     end
  end

  # Check if event Session is new
  def is_session_new?(sip_session_id) do
      query = from e in "events",
          where: e.sipCallID == ^sip_session_id
      Repo.exists?(query)
  end

  def is_session_new(sip_session_id) when sip_session_id == nil, do: "" 

end

