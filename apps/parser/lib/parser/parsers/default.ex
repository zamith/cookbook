defmodule Parser.Parsers.Default do
  def parse(url) do
    {Tesla.get(url).body, %Recipe{}}
    |> find_ingredients()
    |> find_steps()
    |> elem(1)
    |> IO.inspect
  end

  defp find_ingredients({html, recipe}) do
    ingredients =
      html
      |> Floki.find(".ingred-list")
      |> Floki.text
      |> String.split("\n", trim: true)
      |> Stream.map(&String.trim/1)
      |> Enum.map(&(String.replace(&1, ~r/\s+/, " ")))

    {html, %{recipe | ingredients: ingredients}}
  end

  defp find_steps({html, recipe}) do
    steps =
      html
      |> Floki.find(".recipeSteps li")
      |> Stream.map(&Floki.text/1)
      |> Enum.map(&String.trim/1)

    {html, %{recipe | steps: steps}}
  end

end
