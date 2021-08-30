class OrdersPresenter
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def users_orders
    Order.where(user_id: current_user.id)
  end

  def order_status(order)
    case order.status
    when 'complete' then 'Processing'
    when 'in_delivery' then 'In Delivery'
    when 'delivered' then 'Delivered'
    when 'canceled' then 'Canceled'
    else 'Processing Checkout'
    end
  end

  def order_price(order)
    order.order_items.sum { |item| Book.find(item.book_id)[:price] * item.quantity }
  end
end