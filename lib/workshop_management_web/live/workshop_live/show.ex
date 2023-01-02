defmodule WorkshopManagementWeb.WorkshopLive.Show do
  use WorkshopManagementWeb, :live_view

  alias WorkshopManagement.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:workshop, Catalog.get_workshop!(id))}
  end

  @impl true
  def handle_event("delete", _, %{assigns: %{workshop: workshop}} = socket) do
    {:ok, _} = Catalog.delete_workshop(workshop)

    {:noreply,
     socket
     |> put_flash(:info, "Deleted Workshop - #{workshop.title}")
     |> push_navigate(to: ~p"/workshops")}
  end

  defp page_title(:show), do: "Show Workshop"
  defp page_title(:edit), do: "Edit Workshop"
end
