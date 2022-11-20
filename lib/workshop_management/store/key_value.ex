defmodule WorkshopManagement.Store.KeyValue do
  use Agent

  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(key) do
    Agent.get(__MODULE__, fn store -> Map.get(store, key) end)
  end

  def put(key, value) do
    Agent.update(__MODULE__, fn store -> Map.put(store, key, value) end)
  end
end
