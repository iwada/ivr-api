defmodule Ivr.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :time, :string
      add :host, :string
      add :source, :string
      add :transcription, :string
      add :sipcallid, :string
      add :confidence, :string
      add :index, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
