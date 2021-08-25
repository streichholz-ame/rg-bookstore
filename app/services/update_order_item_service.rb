class UpdateOrderItemService
  def initialize(current_order, params)
    @params = params
  end

  def call 
    order_item = find_order_item
    new_params = update_order_item(order_item)
  end

  def find_order_item
    OrderItem.find(params[:id])
  end

  def update_order_item(order_item)
    
  end
end