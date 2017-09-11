defmodule Persistence.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipe) do
      add :title, :string, null: false
      add :url, :string, null: false
      add :image_url, :string
      add :number_of_servings, :string
      add :cooking_time, :string
      add :difficulty, :string
      add :ingredients, :map
      add :steps, :map

      timestamps()
    end
  end
end
