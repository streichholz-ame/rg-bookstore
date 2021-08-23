class OrderItemsController < ApplicationController
  def create
    service = CreateOrderItemService.new(current_user, order_params, params)
    service.call(current_order)
    session[:current_order_id] = service.current_order.id unless current_order
    redirect_success('successfully added')
  end

  def update; end

  def destroy; end

  def order_params
    params.require(:order_item).permit(:book_id, :quantity)
  end

  def redirect_success(message)
    redirect_back(fallback_location: root_path)
    flash[:success] = message
  end
end
