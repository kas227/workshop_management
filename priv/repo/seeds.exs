# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WorkshopManagement.Repo.insert!(%WorkshopManagement.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias WorkshopManagement.Repo
alias WorkshopManagement.Catalog.Workshop

json_file = "#{__DIR__}/workshops.json"

with {:ok, body} <- File.read(json_file),
     {:ok, json} <- Jason.decode(body, keys: :strings) do
  json
  |> Enum.each(fn workshop ->
    Workshop.changeset(%Workshop{}, workshop)
    |> Repo.insert!()
  end)
else
  err -> IO.inspect(err)
end
