class AddCreditCardsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :credit_card
  end
end
