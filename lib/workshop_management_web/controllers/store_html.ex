defmodule WorkshopManagementWeb.StoreHTML do
  use WorkshopManagementWeb, :html

  def index(assigns) do
    ~H"""
    <h2 class="text-2xl font-bold underline my-5">Store</h2>
    <.store_form />
    <ul class="my-5">
      <%= for {key, value} <- @store do %>
        <li><%= key %>: <%= value %></li>
      <% end %>
    </ul>
    """
  end

  defp store_form(assigns) do
    ~H"""
    <form class="grid items-center gap-2 grid-cols-4" action="/store" method="post">
      <label class="text-right col-span-1" for="store_key">Key:</label>
      <input class="rounded col-span-3" type="text" name="store_key" />
      <label class="text-right col-span-1" for="store_value">Value:</label>
      <input class="rounded col-span-3" type="text" name="store_value" />
      <input type="hidden" name="_csrf_token" value={get_csrf_token()} />
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
