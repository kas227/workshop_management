defmodule WorkshopManagement.CatalogTest do
  use WorkshopManagement.DataCase

  alias WorkshopManagement.Catalog

  describe "workshops" do
    alias WorkshopManagement.Catalog.Workshop

    import WorkshopManagement.CatalogFixtures

    @invalid_attrs %{cancelled: nil, description: nil, end: nil, location: nil, max_participants: nil, organizer: nil, participants: nil, registration_deadline: nil, start: nil, title: nil}

    test "list_workshops/0 returns all workshops" do
      workshop = workshop_fixture()
      assert Catalog.list_workshops() == [workshop]
    end

    test "get_workshop!/1 returns the workshop with given id" do
      workshop = workshop_fixture()
      assert Catalog.get_workshop!(workshop.id) == workshop
    end

    test "create_workshop/1 with valid data creates a workshop" do
      valid_attrs = %{cancelled: true, description: "some description", end: ~U[2022-12-30 12:44:00Z], location: "some location", max_participants: 42, organizer: "some organizer", participants: [], registration_deadline: ~U[2022-12-30 12:44:00Z], start: ~U[2022-12-30 12:44:00Z], title: "some title"}

      assert {:ok, %Workshop{} = workshop} = Catalog.create_workshop(valid_attrs)
      assert workshop.cancelled == true
      assert workshop.description == "some description"
      assert workshop.end == ~U[2022-12-30 12:44:00Z]
      assert workshop.location == "some location"
      assert workshop.max_participants == 42
      assert workshop.organizer == "some organizer"
      assert workshop.participants == []
      assert workshop.registration_deadline == ~U[2022-12-30 12:44:00Z]
      assert workshop.start == ~U[2022-12-30 12:44:00Z]
      assert workshop.title == "some title"
    end

    test "create_workshop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_workshop(@invalid_attrs)
    end

    test "update_workshop/2 with valid data updates the workshop" do
      workshop = workshop_fixture()
      update_attrs = %{cancelled: false, description: "some updated description", end: ~U[2022-12-31 12:44:00Z], location: "some updated location", max_participants: 43, organizer: "some updated organizer", participants: [], registration_deadline: ~U[2022-12-31 12:44:00Z], start: ~U[2022-12-31 12:44:00Z], title: "some updated title"}

      assert {:ok, %Workshop{} = workshop} = Catalog.update_workshop(workshop, update_attrs)
      assert workshop.cancelled == false
      assert workshop.description == "some updated description"
      assert workshop.end == ~U[2022-12-31 12:44:00Z]
      assert workshop.location == "some updated location"
      assert workshop.max_participants == 43
      assert workshop.organizer == "some updated organizer"
      assert workshop.participants == []
      assert workshop.registration_deadline == ~U[2022-12-31 12:44:00Z]
      assert workshop.start == ~U[2022-12-31 12:44:00Z]
      assert workshop.title == "some updated title"
    end

    test "update_workshop/2 with invalid data returns error changeset" do
      workshop = workshop_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_workshop(workshop, @invalid_attrs)
      assert workshop == Catalog.get_workshop!(workshop.id)
    end

    test "delete_workshop/1 deletes the workshop" do
      workshop = workshop_fixture()
      assert {:ok, %Workshop{}} = Catalog.delete_workshop(workshop)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_workshop!(workshop.id) end
    end

    test "change_workshop/1 returns a workshop changeset" do
      workshop = workshop_fixture()
      assert %Ecto.Changeset{} = Catalog.change_workshop(workshop)
    end
  end
end
