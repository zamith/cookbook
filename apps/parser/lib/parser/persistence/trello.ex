defmodule Parser.Persistence.Trello do
  def save(recipe = %Recipe{}) do
    recipe
    |> create_trello_card
    |> add_ingredients
    |> add_method
    |> add_image
    :ok
  end

  defp create_trello_card(recipe = %Recipe{}) do
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
end
