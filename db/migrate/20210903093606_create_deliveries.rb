class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.decimal :price
      t.integer :days_min
      t.integer :days_max

      t.timestamps
    end
  end
end
