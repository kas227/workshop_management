defmodule WorkshopManagementWeb.StoreController do
  use WorkshopManagementWeb, :controller
  alias WorkshopManagement.Store.KeyValue

  def index(conn, _params) do
    conn =
      conn
      |> assign(:store, KeyValue.getAll())

    render(conn, :index)
  end
end
