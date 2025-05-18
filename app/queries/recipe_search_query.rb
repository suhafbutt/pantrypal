class RecipeSearchQuery
  def initialize(search_params:, page_number:, per_page:)
    @search_params = search_params
    @page_number = page_number
    @per_page = per_page
    @recipes = Recipe.all
  end

  def filter
    @search_params.each do |filter_name, term|
      @recipes = send("#{filter_name}_filter", term) if term.present?
    end
    page_filter(@page_number, @per_page)
  end

  private

  def include_ingredients_filter(include_ingredients)
    @recipes.joins(:ingredients)
            .where("ingredients.name ILIKE ANY (array[?])", include_ingredients)
            .distinct
  end

  def exclude_ingredients_filter(exclude_ingredients)
    @recipes.where.not(id: Recipe.joins(:ingredients)
            .where("ingredients.name ILIKE ANY (array[?])", exclude_ingredients))
            .distinct
  end

  def page_filter(page_number, per_page)
    @recipes.page(page_number).per(per_page || 10)
  end

  # def have_ingredients
  #   @search_params[:ingredients].split(",").map(&:strip)
  # end

  # def does_not_have_ingredients
  #   @search_params[:have_ingredients].split(",").map(&:strip)
  # end

  def recipe_title_filter(title_query)
    @recipes.where("recipes.title ILIKE ?", "%#{title_query}%")
  end

  def prep_time_filter(prep_time_query)
    @recipes.where("recipes.prep_time <= ?", prep_time_query)
  end

  def cook_time_filter(cook_time_query)
    @recipes.where("recipes.cook_time <= ?", cook_time_query)
  end

  def ratings_filter(ratings_query)
    @recipes.where("recipes.ratings >= ?", ratings_query)
  end
end
