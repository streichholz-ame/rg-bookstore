class CartsController < ApplicationController
  def index
    @cart_presenter = CartPresenter.new(current_order)
    @order_items = OrderItemDecorator.decorate_collection(current_order.order_items)
  end
end
