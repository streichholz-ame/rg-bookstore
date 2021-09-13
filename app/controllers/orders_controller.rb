class OrdersController < ApplicationController
  def index
    @orders_presenter = present(current_user.orders)
  end
end
