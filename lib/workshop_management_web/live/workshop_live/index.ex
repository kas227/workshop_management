defmodule WorkshopManagementWeb.WorkshopLive.Index do
  use WorkshopManagementWeb, :live_view

  alias WorkshopManagement.Catalog
  alias WorkshopManagement.Catalog.Workshop

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :workshops, list_workshops())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Workshop")
    |> assign(:workshop, Catalog.get_workshop!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Workshop")
    |> assign(:workshop, %Workshop{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Workshops")
    |> assign(:workshop, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    workshop = Catalog.get_workshop!(id)
    {:ok, _} = Catalog.delete_workshop(workshop)

    {:noreply, assign(socket, :workshops, list_workshops())}
  end

  defp list_workshops do
    Catalog.list_workshops()
  end
end
