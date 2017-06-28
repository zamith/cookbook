defmodule Trello.Card do
  defstruct [
    :name,
    :desc,
    :list_id,
    pos: "top"
  ]
end
