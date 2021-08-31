class UpdateOrderItemService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    order_item = find_order_item
    new_params = update_order_item(order_item)
    update_item_quantity_in_db(order_item, new_params)
  end

  private

  def find_order_item
    OrderItem.find(params[:id])
  end

  def update_order_item(order_item)
    params[:minus] ? order_item.quantity -= 1 : order_item.quantity += 1
  end

  def update_item_quantity_in_db(order_item, new_params)
    order_item.update(quantity: new_params) if new_params.positive?
  end
end
