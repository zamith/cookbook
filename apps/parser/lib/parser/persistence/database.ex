defmodule Parser.Persistence.Database do
  def save(recipe = %Recipe{}) do
    recipe
    |> Map.from_struct
    |> IO.inspect
    |> Persistence.add_recipe

    recipe
  end
end
