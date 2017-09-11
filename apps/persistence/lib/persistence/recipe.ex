defmodule Persistence.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(title image_url number_of_servings cooking_time difficulty ingredients steps url)a
  @required_fields ~w(title url)a

  schema "recipes" do
    field :title, :string
    field :url, :string
    field :image_url, :string
    field :number_of_servings, :string
    field :cooking_time, :string
    field :difficulty, :string
    field :ingredients, :map
    field :steps, :map

    timestamps()
  end

  def changeset(recipe, params \\ %{}) do
    recipe
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
