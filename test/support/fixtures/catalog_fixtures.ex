defmodule WorkshopManagement.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WorkshopManagement.Catalog` context.
  """

  @doc """
  Generate a workshop.
  """
  def workshop_fixture(attrs \\ %{}) do
    {:ok, workshop} =
      attrs
      |> Enum.into(%{
        cancelled: true,
        description: "some description",
        end: ~U[2022-12-30 12:44:00Z],
        location: "some location",
        max_participants: 42,
        organizer: "some organizer",
        participants: [],
        registration_deadline: ~U[2022-12-30 12:44:00Z],
        start: ~U[2022-12-30 12:44:00Z],
        title: "some title"
      })
      |> WorkshopManagement.Catalog.create_workshop()

    workshop
  end
end
