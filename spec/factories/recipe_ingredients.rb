FactoryBot.define do
  factory :recipe_ingredient do
    recipe
    ingredient
    quantity { 1.0 }
    quantity_text { "1" }
    unit { "cup" }
  end
end
