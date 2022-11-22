defmodule WorkshopManagementWeb.StoreController do
  use WorkshopManagementWeb, :controller
  alias WorkshopManagement.Store.KeyValue

  def index(conn, _params) do
    conn =
      conn
      |> assign(:store, KeyValue.getAll())

    render(conn, :index)
  end

  def new(conn, %{"store_key" => key, "store_value" => value}) do
    :ok = KeyValue.put(key, value)

    conn
    # |> put_flash(:info, "created") # show flash message
    |> redirect(to: ~p"/store")
  end
end
