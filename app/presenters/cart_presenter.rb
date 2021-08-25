class CartPresenter
  def find_book(current_item)
    Book.find(current_item.book_id)
  end

  def subtotal_price(current_item)
    current_item.quantity * find_book(current_item).price
  end

  def book_info(current_item, field)
    find_book(current_item)[field]
  end

  def total_order_price(current_order)
    valid_coupon ? total_price(current_order) : subtotal_order_price(current_order)
  end

  def subtotal_order_price(current_order)
    current_order.order_items.sum { |item| Book.find(item.book_id)[:price] * item.quantity }
  end

  def total_price(current_order)
    subtotal_order_price(current_order) - coupon_price
  end
end
