class AddAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :address
  end
end
