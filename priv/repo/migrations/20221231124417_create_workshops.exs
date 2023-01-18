defmodule WorkshopManagement.Repo.Migrations.CreateWorkshops do
  use Ecto.Migration

  def change do
    create table(:workshops) do
      add :title, :string
      add :organizer, :string
      add :description, :string
      add :location, :string
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :registration_deadline, :utc_datetime
      add :max_participants, :integer
      add :participants, {:array, :string}
      add :cancelled, :boolean, default: false, null: false

      timestamps()
    end
  end
end
