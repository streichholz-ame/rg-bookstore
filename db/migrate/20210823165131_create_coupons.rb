class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :number
      t.decimal :discount, default: (3..10).to_a.sample, precision: 2
      t.timestamps
    end
  end
end
