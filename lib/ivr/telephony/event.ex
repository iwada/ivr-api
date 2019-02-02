defmodule Ivr.Telephony.Event do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :confidence, :float
    field :host, :string
    field :index, :string
    field :sipCallID, :string
    field :source, :string
    field :sourcetype, :string
    field :sipToURI, :string
    field :sipFromURI, :string
    field :time, :integer
    field :transcription, :string
    field :is_session_new, :boolean
    belongs_to :user, Ivr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:time, :host, :source, :transcription, :sipCallID, :confidence, :index,:sourcetype,:sipToURI,:sipFromURI,:is_session_new])
    #|> validate_required([:time, :host, :source, :transcription, :sipCallID, :confidence, :index,:sourceType,:sipToURI])
  end
end
