class CreateCuisines < ActiveRecord::Migration[8.0]
  def change
    create_table :cuisines do |t|
      t.string :name

      t.timestamps
    end
    add_index :cuisines, :name, unique: true
  end
end
