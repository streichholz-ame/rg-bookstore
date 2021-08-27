class DeleteOrderItemService
  attr_reader :params, :current_order

  def initialize(current_order, params)
    @params = params
    @current_order = current_order
  end

  def call
    delete_item
    delete_coupon if order_empty?
  end

  def delete_order?
    current_order.destroy if order_empty?
  end

  private

  def delete_item
    current_order.order_items.find(params[:id]).delete
  end

  def delete_coupon
    current_order.update(coupon_id: nil)
  end

  def order_empty?
    current_order.order_items.empty?
  end
end
