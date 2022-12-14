defmodule WorkshopManagementWeb.Router do
  use WorkshopManagementWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WorkshopManagementWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WorkshopManagementWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/store", StoreController, :index
    post "/store", StoreController, :new

    live "/store_live", WorkshopLive.StoreLive, :index

    live "/workshops", WorkshopLive.Index, :index
    live "/workshops/new", WorkshopLive.Index, :new
    live "/workshops/:id", WorkshopLive.Show, :show
    live "/workshops/:id/edit", WorkshopLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", WorkshopManagementWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:workshop_management, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WorkshopManagementWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
