defmodule WorkshopManagement.Repo do
  use Ecto.Repo,
    otp_app: :workshop_management,
    adapter: Ecto.Adapters.SQLite3
end
