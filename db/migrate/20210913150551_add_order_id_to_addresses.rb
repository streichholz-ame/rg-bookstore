class AddOrderIdToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :order
  end
end
