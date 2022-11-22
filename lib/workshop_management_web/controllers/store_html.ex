defmodule WorkshopManagementWeb.StoreHTML do
  use WorkshopManagementWeb, :html

  def index(assigns) do
    ~H"""
    <h2 class="text-2xl font-bold underline my-5">Store</h2>
    <ul class="my-5">
      <%= for {key, value} <- @store do %>
        <li><%= key %>: <%= value %></li>
      <% end %>
    </ul>
    """
  end
    """
  end
end
