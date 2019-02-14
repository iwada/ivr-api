defmodule Ivr.Repo.Migrations.CreateInwarddials do
  use Ecto.Migration

  def change do
    create table(:inwarddials, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :direct_inward_dial_number, :string
      add :status, :boolean, default: true, null: false
      add :user_id, references(:users, on_delete: :delete_all, type: :uuid)

      timestamps()
    end
    create unique_index(:inwarddials, [:direct_inward_dial_number])
  end
end
