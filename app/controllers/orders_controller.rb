class OrdersController < ApplicationController
  before_action :filter_orders, only: :index

  def index
    authorize Order
    @orders = OrderDecorator.decorate_collection(@filtered_orders)
  end

  def show
    order = Order.find_by(id: params[:id])
    authorize order
    @order = order.decorate
    @order_items = OrderItemDecorator.decorate_collection(@order.order_items)
  end

  private

  def filter_orders
    authorize Order
    status = params[:status]
    @filtered_orders = status ? current_user.orders.public_send(status) : current_user.orders
  end
end
