defmodule Ivr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ivr.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :verified, :boolean, default: false
    has_many :events, Ivr.Telephony.Event
    has_many :inwarddials, Ivr.Telephony.InwardDial
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash,:verified])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_length(:name, min: 2, max: 255)
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
  end


    def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
