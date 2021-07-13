class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.text :description
      t.string :photo
      t.decimal :price
      t.integer :publication_year
      t.float :height
      t.float :width
      t.float :depth
      t.string :material

      t.timestamps
    end
  end
end
