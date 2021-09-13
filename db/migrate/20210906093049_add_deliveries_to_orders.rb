class AddDeliveriesToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :delivery
  end
end
