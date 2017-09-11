defmodule Parser.Runner do
  @spec parse(String.t, module) :: :ok
  def parse(url, parser) do
    {Tesla.get(url).body, %Recipe{url: url}}
    |> parser.find_title
    |> parser.find_ingredients
    |> parser.find_steps
    |> parser.find_image_url
    |> parser.find_number_of_servings
    |> parser.find_cooking_time
    |> parser.find_difficulty
    |> write_description
    |> elem(1)
    |> Parser.Persistence.Database.save
    # |> Parser.Persistence.Trello.save
    :ok
  end

  defp write_description({html, recipe = %Recipe{}}) do
    desc = """
    [Original](#{recipe.url})

    * **Serves:** #{recipe.number_of_servings}
    * **Cooks in:** #{recipe.cooking_time}
    * **Difficulty:** #{recipe.difficulty}
    """

    {html, %{recipe | desc: desc}}
  end
end
