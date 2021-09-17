class OrdersController < ApplicationController
  before_action :filter_orders

  def index
    authorize Order
    @orders_presenter = present(current_user.orders)
    @orders = OrderDecorator.decorate_collection(@filtered_orders)
  end

  def show
    @order = Order.find_by(id: params[:id])
    authorize @order
    @orders = @order.decorate
    @order_items = @order.order_items
  end

  private

  def filter_orders
    status = params[:status]
    @filtered_orders = params[:status].nil? ? current_user.orders : current_user.orders.send(status)
  end
end
