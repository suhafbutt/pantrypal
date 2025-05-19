class IngredientsController < ApplicationController
  def index
    query = params[:query].to_s.downcase
    matches = Ingredient.names_for_given_query(query, 10)
    render json: matches
  end
end
