defmodule Parser.Parsers.JamieOliver do
  @behaviour Parser.Parsers.Generic

  def find_title({html, recipe}) do
    title =
      html
      |> Floki.find("h1")
      |> Floki.text

    {html, %{recipe | title: title}}
  end

  def find_ingredients({html, recipe = %Recipe{}}) do
    ingredients =
      html
      |> Floki.find(".ingred-list")
      |> Floki.text
      |> String.split("\n", trim: true)
      |> Stream.map(&String.trim/1)
      |> Enum.map(&(String.replace(&1, ~r/\s+/, " ")))

    {html, %{recipe | ingredients: ingredients}}
  end

  def find_steps({html, recipe = %Recipe{}}) do
    steps =
      html
      |> Floki.find(".recipeSteps li")
      |> Stream.map(&Floki.text/1)
      |> Enum.map(&String.trim/1)

    {html, %{recipe | steps: steps}}
  end

  def find_image_url({html, recipe = %Recipe{}}) do
    image_url =
      html
      |> Floki.find("picture img")
      |> Floki.attribute("src")
      |> List.first
      |> sanitize_url

    {html, %{recipe | image_url: image_url}}
  end

  def find_number_of_servings({html, recipe = %Recipe{}}) do
    number_of_servings =
      html
      |> Floki.find(".recipe-detail.serves")
      |> List.first
      |> elem(2)
      |> List.last
      |> String.trim

    {html, %{recipe | number_of_servings: number_of_servings}}
  end

  def find_cooking_time({html, recipe = %Recipe{}}) do
    cooking_time =
      html
      |> Floki.find(".recipe-detail.time")
      |> List.first
      |> elem(2)
      |> List.last
      |> String.trim

    {html, %{recipe | cooking_time: cooking_time}}
  end

  def find_difficulty({html, recipe = %Recipe{}}) do
    difficulty =
      html
      |> Floki.find(".recipe-detail.difficulty")
      |> List.first
      |> elem(2)
      |> List.last
      |> String.trim

    {html, %{recipe | difficulty: difficulty}}
  end

  defp sanitize_url("//" <> url) do
    "https://#{url}"
  end
  defp sanitize_url(url), do: url
end
