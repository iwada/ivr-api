defmodule Ivr.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :time, :integer
      add :host, :string
      add :source, :string
      add :sourcetype, :string
      add :sipToURI, :string
      add :transcription, :string
      add :sipCallID, :string
      add :sipFromURI, :string
      add :confidence, :float
      add :index, :string
      add :is_session_new, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end

  end
end
