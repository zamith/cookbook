defmodule Parser.Parsers.JamieOliver do
  def parse(url) do
    {Tesla.get(url).body, %Recipe{url: url}}
    |> find_title
    |> find_ingredients
    |> find_steps
    |> find_image_url
    |> write_description
    |> create_trello_card
    |> add_ingredients
    |> add_method
    |> add_image
    :ok
  end

  defp find_title({html, recipe}) do
    title =
      html
      |> Floki.find("h1")
      |> Floki.text

    {html, %{recipe | title: title}}
  end

  defp find_ingredients({html, recipe = %Recipe{}}) do
    ingredients =
      html
      |> Floki.find(".ingred-list")
      |> Floki.text
      |> String.split("\n", trim: true)
      |> Stream.map(&String.trim/1)
      |> Enum.map(&(String.replace(&1, ~r/\s+/, " ")))

    {html, %{recipe | ingredients: ingredients}}
  end

  defp find_steps({html, recipe = %Recipe{}}) do
    steps =
      html
      |> Floki.find(".recipeSteps li")
      |> Stream.map(&Floki.text/1)
      |> Enum.map(&String.trim/1)

    {html, %{recipe | steps: steps}}
  end

  defp find_image_url({html, recipe = %Recipe{}}) do
    image_url =
      html
      |> Floki.find("picture img")
      |> Floki.attribute("src")
      |> List.first
      |> sanitize_url

    IO.inspect image_url

    {html, %{recipe | image_url: image_url}}
  end

  defp write_description({html, recipe = %Recipe{url: url}}) do
    desc = """
    [Original](#{url})

    * **Serves:** 4-6
    * **Cooks in:** 1h 30 min
    * **Difficulty:** HARDISH
    """

    {html, %{recipe | desc: desc}}
  end

  defp create_trello_card({_, recipe = %Recipe{}}) do
    %{"id" => card_id} = Trello.create(
      :card,
      %Trello.Card{
        name: recipe.title,
        list_id: "593dce20e4ddfe11712214b4",
        desc: recipe.desc,
      }
    )
    {card_id, recipe}
  end

  defp add_ingredients({card_id, recipe = %Recipe{}}) do
    Trello.create(:checklist, card_id, "Ingredients", recipe.ingredients)
    {card_id, recipe}
  end

  defp add_method({card_id, recipe = %Recipe{}}) do
    Trello.create(:checklist, card_id, "Method", recipe.steps)
    {card_id, recipe}
  end

  defp add_image({card_id, recipe = %Recipe{}}) do
    Trello.create(:attachment, card_id, recipe.image_url)
    {card_id, recipe}
  end

  defp sanitize_url("//" <> url) do
    "https://#{url}"
  end
  defp sanitize_url(url), do: url
end
