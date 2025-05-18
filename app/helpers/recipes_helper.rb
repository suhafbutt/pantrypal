module RecipesHelper
  def get_recipe_image(recipe)
    recipe.image.presence || "default-recipe.png"
  end
end
