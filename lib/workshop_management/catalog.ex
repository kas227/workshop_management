defmodule WorkshopManagement.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias WorkshopManagement.Repo

  alias WorkshopManagement.Catalog.Workshop

  @doc """
  Returns the list of workshops.

  ## Examples

      iex> list_workshops()
      [%Workshop{}, ...]

  """
  def list_workshops do
    Repo.all(Workshop)
  end

  @doc """
  Gets a single workshop.

  Raises `Ecto.NoResultsError` if the Workshop does not exist.

  ## Examples

      iex> get_workshop!(123)
      %Workshop{}

      iex> get_workshop!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workshop!(id), do: Repo.get!(Workshop, id)

  @doc """
  Creates a workshop.

  ## Examples

      iex> create_workshop(%{field: value})
      {:ok, %Workshop{}}

      iex> create_workshop(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workshop(attrs \\ %{}) do
    %Workshop{}
    |> Workshop.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workshop.

  ## Examples

      iex> update_workshop(workshop, %{field: new_value})
      {:ok, %Workshop{}}

      iex> update_workshop(workshop, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workshop(%Workshop{} = workshop, attrs) do
    workshop
    |> Workshop.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workshop.

  ## Examples

      iex> delete_workshop(workshop)
      {:ok, %Workshop{}}

      iex> delete_workshop(workshop)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workshop(%Workshop{} = workshop) do
    Repo.delete(workshop)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workshop changes.

  ## Examples

      iex> change_workshop(workshop)
      %Ecto.Changeset{data: %Workshop{}}

  """
  def change_workshop(%Workshop{} = workshop, attrs \\ %{}) do
    Workshop.changeset(workshop, attrs)
  end
end
