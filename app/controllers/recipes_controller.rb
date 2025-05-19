class RecipesController < ApplicationController
  before_action :set_recipe, only: :show

  def index
    @recipes = RecipeSearchQuery.new(search_params: permit_search_params,
                                      page_number: params[:page],
                                      per_page: params[:per_page]).filter
  end

  def show
    return redirect_to recipes_path, alert: "Recipe not found" unless @recipe.present?

    @recipe_ingredients = @recipe.recipe_ingredients.includes(:ingredient)
  end

  private

  def permit_search_params
    params.permit(:included_ingredients, :excluded_ingredients, :recipe_title, :prep_time, :cook_time, :ratings)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end
end
