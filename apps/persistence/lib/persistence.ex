defmodule Persistence do
  alias Persistence.{
    Recipe,
    Repo,
  }

  def add_recipe(%{
    title: _,
    image_url: _,
    number_of_servings: _,
    cooking_time: _,
    difficulty: _,
    ingredients: _,
    steps: _,
  } = data) do
    Recipe.changeset(%Recipe{}, data)
    |> Repo.insert
  end
end
