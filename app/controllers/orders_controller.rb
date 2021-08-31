class OrdersController < ApplicationController
  def index
    @orders_presenter = OrdersPresenter.new(current_user)
  end
end
