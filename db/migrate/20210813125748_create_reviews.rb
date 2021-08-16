class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :review_text
      t.string :text
      t.integer :rating
      t.references :user
      t.references :book
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
