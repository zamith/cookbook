defmodule Trello do
  use Tesla

  plug Tesla.Middleware.Tuples
  plug Tesla.Middleware.BaseUrl, "https://api.trello.com/1"
  plug Tesla.Middleware.Headers, %{"Content-Type" => "application/json"}
  plug Tesla.Middleware.Query, [key: Application.get_env(:trello, :key), token: Application.get_env(:trello, :token)]
  plug Tesla.Middleware.JSON

  alias Trello.Card

  def create(:card, card = %Card{}) do
    {:ok, env} = post("/lists/#{card.list_id}/cards", %{}, query: [name: card.name, desc: card.desc])
    env.body
  end

  def create(:attachment, card_id, image_url) do
    post("/cards/#{card_id}/attachments", %{}, query: [url: image_url])
  end

  def create(:checklist, card_id, name, items \\ []) do
    {:ok, env} = post("/cards/#{card_id}/checklists", %{}, query: [name: name])
    %{"id" => checklist_id} = env.body
    Enum.each(items, fn(item) ->
      post("/cards/#{card_id}/checklist/#{checklist_id}/checkItem", %{}, query: [name: item])
    end)
  end
end
