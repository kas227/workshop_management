defmodule WorkshopManagementWeb.WorkshopLive.FormComponent do
  use WorkshopManagementWeb, :live_component

  alias WorkshopManagement.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage workshop records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="workshop-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :title}} type="text" label="title" />
        <.input field={{f, :organizer}} type="text" label="organizer" />
        <.input field={{f, :description}} type="text" label="description" />
        <.input field={{f, :location}} type="text" label="location" />
        <.input field={{f, :start}} type="datetime-local" label="start" />
        <.input field={{f, :end}} type="datetime-local" label="end" />
        <.input field={{f, :registration_deadline}} type="datetime-local" label="registration_deadline" />
        <.input field={{f, :max_participants}} type="number" label="max_participants" />
        <.input
          field={{f, :participants}}
          type="select"
          multiple
          label="participants"
          options={[{"Option 1", "option1"}, {"Option 2", "option2"}]}
        />
        <.input field={{f, :cancelled}} type="checkbox" label="cancelled" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Workshop</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{workshop: workshop} = assigns, socket) do
    changeset = Catalog.change_workshop(workshop)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"workshop" => workshop_params}, socket) do
    changeset =
      socket.assigns.workshop
      |> Catalog.change_workshop(workshop_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"workshop" => workshop_params}, socket) do
    save_workshop(socket, socket.assigns.action, workshop_params)
  end

  defp save_workshop(socket, :edit, workshop_params) do
    case Catalog.update_workshop(socket.assigns.workshop, workshop_params) do
      {:ok, _workshop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workshop updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_workshop(socket, :new, workshop_params) do
    case Catalog.create_workshop(workshop_params) do
      {:ok, _workshop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workshop created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
