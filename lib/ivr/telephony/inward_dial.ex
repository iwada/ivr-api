defmodule Ivr.Telephony.InwardDial do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "inwarddials" do
    field :direct_inward_dial_number, :string
    field :status, :boolean, default: true
    belongs_to :user, Ivr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(inward_dial, attrs) do
    inward_dial
    |> cast(attrs, [:direct_inward_dial_number, :status])
    |> unique_constraint(:direct_inward_dial_number)
    |> validate_required([:direct_inward_dial_number])
  end
end
