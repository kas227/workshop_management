defmodule WorkshopManagementWeb.WorkshopLiveTest do
  use WorkshopManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import WorkshopManagement.CatalogFixtures

  @create_attrs %{cancelled: true, description: "some description", end: "2022-12-30T12:44:00Z", location: "some location", max_participants: 42, organizer: "some organizer", participants: [], registration_deadline: "2022-12-30T12:44:00Z", start: "2022-12-30T12:44:00Z", title: "some title"}
  @update_attrs %{cancelled: false, description: "some updated description", end: "2022-12-31T12:44:00Z", location: "some updated location", max_participants: 43, organizer: "some updated organizer", participants: [], registration_deadline: "2022-12-31T12:44:00Z", start: "2022-12-31T12:44:00Z", title: "some updated title"}
  @invalid_attrs %{cancelled: false, description: nil, end: nil, location: nil, max_participants: nil, organizer: nil, participants: [], registration_deadline: nil, start: nil, title: nil}

  defp create_workshop(_) do
    workshop = workshop_fixture()
    %{workshop: workshop}
  end

  describe "Index" do
    setup [:create_workshop]

    test "lists all workshops", %{conn: conn, workshop: workshop} do
      {:ok, _index_live, html} = live(conn, ~p"/workshops")

      assert html =~ "Listing Workshops"
      assert html =~ workshop.description
    end

    test "saves new workshop", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/workshops")

      assert index_live |> element("a", "New Workshop") |> render_click() =~
               "New Workshop"

      assert_patch(index_live, ~p"/workshops/new")

      assert index_live
             |> form("#workshop-form", workshop: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#workshop-form", workshop: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/workshops")

      assert html =~ "Workshop created successfully"
      assert html =~ "some description"
    end

    test "updates workshop in listing", %{conn: conn, workshop: workshop} do
      {:ok, index_live, _html} = live(conn, ~p"/workshops")

      assert index_live |> element("#workshops-#{workshop.id} a", "Edit") |> render_click() =~
               "Edit Workshop"

      assert_patch(index_live, ~p"/workshops/#{workshop}/edit")

      assert index_live
             |> form("#workshop-form", workshop: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#workshop-form", workshop: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/workshops")

      assert html =~ "Workshop updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes workshop in listing", %{conn: conn, workshop: workshop} do
      {:ok, index_live, _html} = live(conn, ~p"/workshops")

      assert index_live |> element("#workshops-#{workshop.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#workshop-#{workshop.id}")
    end
  end

  describe "Show" do
    setup [:create_workshop]

    test "displays workshop", %{conn: conn, workshop: workshop} do
      {:ok, _show_live, html} = live(conn, ~p"/workshops/#{workshop}")

      assert html =~ "Show Workshop"
      assert html =~ workshop.description
    end

    test "updates workshop within modal", %{conn: conn, workshop: workshop} do
      {:ok, show_live, _html} = live(conn, ~p"/workshops/#{workshop}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Workshop"

      assert_patch(show_live, ~p"/workshops/#{workshop}/show/edit")

      assert show_live
             |> form("#workshop-form", workshop: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#workshop-form", workshop: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/workshops/#{workshop}")

      assert html =~ "Workshop updated successfully"
      assert html =~ "some updated description"
    end
  end
end
