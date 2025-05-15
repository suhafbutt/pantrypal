class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.string :image
      t.references :author, index: true, foreign_key: {to_table: :users}
      t.references :category, index: true, null: false, foreign_key: true
      t.references :cuisine, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
