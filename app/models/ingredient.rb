class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true

  scope :names_for_given_query, ->(query, record_limit) { where("LOWER(name) LIKE ?", "%#{query}%").limit(record_limit).pluck(:name) }
end
