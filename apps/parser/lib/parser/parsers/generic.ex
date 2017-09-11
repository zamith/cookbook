defmodule Parser.Parsers.Generic do
  @callback find_title({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
  @callback find_ingredients({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
  @callback find_steps({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
  @callback find_image_url({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
  @callback find_number_of_servings({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
  @callback find_cooking_time({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
  @callback find_difficulty({HTML.t, Recipe.t}) :: {HTML.t, Recipe.t}
end
