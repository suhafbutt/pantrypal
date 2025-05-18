class IngredientsController < ApplicationController
  def index
    query = params[:query].to_s.downcase
    matches = Ingredient.where("LOWER(name) LIKE ?", "%#{query}%").limit(10).pluck(:name)
    render json: matches
  end
end
