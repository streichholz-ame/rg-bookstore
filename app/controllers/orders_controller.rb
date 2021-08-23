class OrdersController < ApplicationController
  def show
    @order_presenter = OrderPresenter.new(current_order)
  end
end
