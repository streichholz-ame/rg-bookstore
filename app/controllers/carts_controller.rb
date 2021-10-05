class CartsController < ApplicationController
  def index
    @cart_presenter = CartPresenter.new(current_order)
    @order_item = OrderItemDecorator.decorate(current_order.order_items)
  end
end
