class OrderItemDecorator < ApplicationDecorator
  delegate_all

  def order_item_price(item)
    item.book[:price] * item.quantity
  end

  def subtotal_price(item)
    item.quantity * item.book.price
  end
end
