class DeleteOrderItemService
  attr_reader :params, :current_order

  def initialize(current_order, params)
    @params = params
    @current_order = current_order
  end

  def call
    delete_item
  end

  private

  def delete_item
    current_order.order_items.find(params[:id]).delete
  end
end
