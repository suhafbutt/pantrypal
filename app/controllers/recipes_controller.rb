class RecipesController < ApplicationController
  def search
    if params[:ingredients].present?
      ingredient_list = params[:ingredients].split(",").map(&:strip)
      @recipes = Recipe.joins(:ingredients).where(ingredients: { name: ingredient_list }).limit(10).distinct
    else
      @recipes = Recipe.limit(10)
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
