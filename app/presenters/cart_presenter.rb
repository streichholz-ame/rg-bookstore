class CartPresenter < ApplicationPresenter
  attr_reader :current_order

  EMPTY_COUPON_PRICE = 0

  def initialize(current_order)
    @current_order = current_order
  end

  def find_book(current_item)
    Book.find(current_item.book_id)
  end

  def subtotal_price(current_item)
    current_item.quantity * find_book(current_item).price
  end

  def book_info(current_item, field)
    find_book(current_item)[field]
  end

  def total_order_price
    current_order.coupon ? total_price_with_coupon : subtotal_order_price
  end

  def subtotal_order_price
    current_order.order_items.sum { |item| Book.find(item.book_id)[:price] * item.quantity }
  end

  def total_price_with_coupon
    total_price = subtotal_order_price - coupon_price
    total_price.round(2)
  end

  def delivery_type
    Delivery.find(current_order.delivery_id)
  end

  def subtotal_price_with_delivery
    subtotal_order_price + delivery_type.price
  end

  def total_price_with_delivery
    (subtotal_price_with_delivery - coupon_price).round(2)
  end

  def coupon_price
    if current_order.coupon
      total = (current_order.coupon.discount * subtotal_order_price) / 100
      total.round(2)
    else
      EMPTY_COUPON_PRICE
    end
  end
end
