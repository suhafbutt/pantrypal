class User < ApplicationRecord
  has_many :recipes, foreign_key: :author_id, class_name: 'Recipe'
end
