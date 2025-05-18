puts "Starting seeding process..."
file_path = Rails.root.join('db', 'recipes-en.json')
recipes = JSON.parse(File.read(file_path))

recipes.each_with_index do |data, index|
  puts "Seeding recipe #{index + 1}/#{recipes.size}: #{data['title']}"

  category = Category.find_or_create_by!(name: data['category']) if data['category'].present?
  cuisine = Cuisine.find_or_create_by!(name: data['cuisine']) if data['cuisine'].present?
  author = User.find_or_create_by!(name: data['author']) if data['author'].present?

  recipe = Recipe.create!(
    title: data['title'],
    cook_time: data['cook_time'],
    prep_time: data['prep_time'],
    ratings: data['ratings'],
    author: author,
    image: DataSanitizer::Image.image_decode(data['image']),
    category: category,
    cuisine: cuisine
  )

  data['ingredients'].each do |ingredient_line|
    match = ingredient_line.match(/^([\d\s\/½⅓⅔¼¾⅛⅜⅝⅞\.-]+)?\s*([a-zA-Z]+)?\s+(.*)$/)

    if match.present?
      quantity_text = match[1]&.strip
      unit          = match[2]&.strip
      name          = match[3]&.strip
    else
      quantity_text = 'to taste'
      unit = 0.0
      name = ingredient_line.strip
    end

    ingredient = Ingredient.find_or_create_by!(name: name)
    quantity = DataSanitizer::Quantity.parse_quantity(quantity_text)

    RecipeIngredient.create!(
      recipe: recipe,
      ingredient: ingredient,
      quantity: quantity || 0.0,
      quantity_text: quantity_text.presence || 'to taste',
      unit: unit
    )
  end
end

puts "Seeding complete! Total recipes: #{Recipe.count}, Total ingredients: #{Ingredient.count}"
