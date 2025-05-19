class AddIndexesForRecipeSearch < ActiveRecord::Migration[8.0]
  def change
    add_index :ingredients, :name
    add_index :recipes, :title
    add_index :recipes, :prep_time
    add_index :recipes, :cook_time
    add_index :recipes, :ratings
  end
end
