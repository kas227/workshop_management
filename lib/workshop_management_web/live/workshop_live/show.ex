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

  defp page_title(:show), do: "Show Workshop"
  defp page_title(:edit), do: "Edit Workshop"
end
