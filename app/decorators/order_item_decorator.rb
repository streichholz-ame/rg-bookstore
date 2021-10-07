class OrderItemDecorator < ApplicationDecorator
  delegate_all

  def order_item_price
    object.book.price * object.quantity
  end
end
