defmodule WorkshopManagementWeb.WorkshopLive.StoreLive do
  use WorkshopManagementWeb, :live_view
  alias WorkshopManagementWeb.Endpoint
  alias WorkshopManagement.Store.KeyValue

  @store_update_topic "store_update"

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Endpoint.subscribe(@store_update_topic)

    socket =
      socket
      |> assign(:store, KeyValue.getAll())

    {:ok, socket}
  end

  @impl true
  def handle_event("new", %{"store_key" => key, "store_value" => value}, socket)
      when key == "" or value == "" do
    socket =
      socket
      |> put_flash(:error, "Key or Value cannot be empty!")

    {:noreply, socket}
  end

  @impl true
  def handle_event("new", %{"store_key" => key, "store_value" => value}, socket) do
    :ok = KeyValue.put(key, value)

    :ok = Endpoint.broadcast(@store_update_topic, "updated", "")
    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "updated"}, socket) do
    socket =
      socket
      |> assign(:store, KeyValue.getAll())
      |> put_flash(:info, "New entry!")

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h2 class="text-2xl font-bold underline my-5">Store</h2>
    <.store_form />
    <ul class="my-5">
      <%= for {key, value} <- @store do %>
        <li id={key}><%= key %>: <%= value %></li>
      <% end %>
    </ul>
    """
  end

  defp store_form(assigns) do
    ~H"""
    <form class="grid items-center gap-2 grid-cols-4" phx-submit="new">
      <label class="text-right col-span-1" for="store_key">Key:</label>
      <input class="rounded col-span-3" type="text" name="store_key" />
      <label class="text-right col-span-1" for="store_value">Value:</label>
      <input class="rounded col-span-3" type="text" name="store_value" />
      <input type="hidden" name="_csrf_token" value={Plug.CSRFProtection.get_csrf_token()} />
      <button
        class="col-start-3 col-span-2 bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        type="submit"
      >
        Send
      </button>
    </form>
    """
  end
end
