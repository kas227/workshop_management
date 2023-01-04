defmodule WorkshopManagement.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WorkshopManagementWeb.Telemetry,
      # Start the Ecto repository
      WorkshopManagement.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WorkshopManagement.PubSub},
      # Start Finch
      {Finch, name: WorkshopManagement.Finch},
      # Start the Endpoint (http/https)
      WorkshopManagementWeb.Endpoint
      # Start a worker by calling: WorkshopManagement.Worker.start_link(arg)
      # {WorkshopManagement.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WorkshopManagement.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WorkshopManagementWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
