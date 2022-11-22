defmodule WorkshopManagementWeb.StoreController do
  use WorkshopManagementWeb, :controller

  def index(conn, _params) do
    conn
    |> resp(200, "Hello World!")
  end
end
