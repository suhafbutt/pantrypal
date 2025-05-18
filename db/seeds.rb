require 'json'

def parse_quantity(quantity_text)
  return nil unless quantity_text.present?

  normalized = quantity_text.gsub(/[½⅓⅔¼¾⅛⅜⅝⅞]/, {
    '½' => '0.5', '⅓' => '0.333', '⅔' => '0.667',
    '¼' => '0.25', '¾' => '0.75', '⅛' => '0.125',
    '⅜' => '0.375', '⅝' => '0.625', '⅞' => '0.875'
  })

  parts = normalized.strip.split
  total = 0.0

  parts.each do |part|
    if part.include?('/')
      numerator, denominator = part.split('/')
      if numerator && denominator
        total += numerator.to_f / denominator.to_f
      end
    else
      total += Float(part) rescue 0
    end
  end

  total > 0 ? total : nil
end

def image_decode(image_url)
  CGI.unescape(image_url).split('url=')[1]
end


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
    image: image_decode(data['image']),
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
    quantity = parse_quantity(quantity_text)

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
