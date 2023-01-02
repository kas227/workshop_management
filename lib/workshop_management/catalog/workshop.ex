defmodule WorkshopManagement.Catalog.Workshop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workshops" do
    field :cancelled, :boolean, default: false
    field :description, :string
    field :end, :utc_datetime
    field :location, :string
    field :max_participants, :integer
    field :organizer, :string
    field :participants, {:array, :string}, default: []
    field :registration_deadline, :utc_datetime
    field :start, :utc_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(workshop, attrs) do
    workshop
    |> cast(attrs, [:title, :organizer, :description, :location, :start, :end, :registration_deadline, :max_participants, :participants, :cancelled])
    |> validate_required([:title, :organizer, :description, :location, :start, :end, :registration_deadline, :max_participants, :cancelled])
  end
end
