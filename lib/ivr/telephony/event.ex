defmodule Ivr.Telephony.Event do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :confidence, :string
    field :host, :string
    field :index, :string
    field :sipcallid, :string
    field :source, :string
    field :time, :string
    field :transcription, :string
    belongs_to :user, Ivr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:time, :host, :source, :transcription, :sipcallid, :confidence, :index])
    |> validate_required([:time, :host, :source, :transcription, :sipcallid, :confidence, :index])
  end
end
