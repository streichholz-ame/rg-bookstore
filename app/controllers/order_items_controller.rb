class OrderItemsController < ApplicationController
  def create
    create_service = CreateOrderItemService.new(order_params, params)
    create_service.call(current_order)
    session[:current_order_id] = create_service.current_order.id if current_order
    redirect_success(I18n.t('cart.added'))
  end

  def update
    update_service = UpdateOrderItemService.new(params)
    update_service.call
    respond_to { |format| format.html { redirect_to carts_path } }
  end

  def destroy
    delete_service = DeleteOrderItemService.new(current_order, params)
    delete_service.call
    session.delete(:current_order_id) if delete_service.delete_order?
    redirect_success(I18n.t('cart.deleted'))
  end

  private

  def order_params
    params.require(:order_item).permit(:book_id, :quantity, :user_id)
  end

  def redirect_success(message)
    redirect_back(fallback_location: root_path)
    flash[:success] = message
  end
end
