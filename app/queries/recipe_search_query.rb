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
    paginate(@page_number, @per_page).distinct
  end

  private

  def included_ingredients_filter(included_ingredients)
    ingredient_names = convert_to_array(included_ingredients)
    @recipes.joins(:ingredients)
            .where("ingredients.name ILIKE ANY (array[?])", ingredient_names)
            .group('recipes.id')
            .having('COUNT(DISTINCT ingredients.id) = ?', ingredient_names.size)
  end

  def excluded_ingredients_filter(excluded_ingredients)
    @recipes.where.not(id: Recipe.joins(:ingredients)
            .where("ingredients.name ILIKE ANY (array[?])", convert_to_array(excluded_ingredients)))
  end

  def paginate(page_number, per_page)
    @recipes.page(page_number).per(per_page || 10)
  end

  def convert_to_array(ingredient_list)
    ingredient_list.split(",").map(&:strip)
  end

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
