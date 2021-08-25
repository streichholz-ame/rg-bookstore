class CartsController < ApplicationController
  def index 
    @cart_presenter = CartPresenter.new
    if current_user
      @order_items = Order.where(user_id: current_user.id).last.order_items
    else
      @order_items = current_order.order_items
    end
  end
end
