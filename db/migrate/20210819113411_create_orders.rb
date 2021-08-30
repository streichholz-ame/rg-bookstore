class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :coupon
      t.integer :status, default: 0, null: false
      t.string :number

      t.timestamps
    end
  end
end
