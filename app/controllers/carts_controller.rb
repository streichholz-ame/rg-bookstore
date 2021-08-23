class CartsController < ApplicationController
  def index 
    @cart_presenter = CartPresenter.new
    @order_items = current_order.order_items
  end
end
