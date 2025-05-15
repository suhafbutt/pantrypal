class Recipe < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :cuisine, optional: true
  belongs_to :author, class_name: 'User', optional: true
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
