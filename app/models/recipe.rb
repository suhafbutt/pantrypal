class Recipe < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :cuisine, optional: true
  belongs_to :author, class_name: "User", optional: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, presence: true
  validates :prep_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cook_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :ratings, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
end
