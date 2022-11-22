defmodule WorkshopManagementWeb.StoreHTML do
  use WorkshopManagementWeb, :html

  def index(assigns) do
    ~H"""
    <div>Hello <%= @message %></div>
    """
  end
end
