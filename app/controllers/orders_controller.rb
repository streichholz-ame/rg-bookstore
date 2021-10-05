class OrdersController < ApplicationController
  before_action :filter_orders, only: :index

  def index
    authorize Order
    @orders_presenter = present(current_user.orders)
    @orders = OrderDecorator.decorate_collection(@filtered_orders)
  end

  def show
    @order = Order.find_by(id: params[:id])
    authorize @order
    @orders = @order.decorate
    @order_item = OrderItemDecorator.decorate(@order.order_items)
  end

  private

  def filter_orders
    authorize Order
    status = params[:status]
    @filtered_orders = status ? current_user.orders.public_send(status) : current_user.orders
  end
end
