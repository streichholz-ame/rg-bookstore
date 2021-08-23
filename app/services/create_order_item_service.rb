class CreateOrderItemService
  attr_reader :current_user, :current_order, :order_params, :params, :order_item_form

  def initialize(current_user, order_params, params)
    @current_user = current_user
    @params = params
    @order_params = order_params
    @order_item_form = OrderItemForm.new(order_params)
  end

  def call(current_order)
    @current_order = current_order
    create_order_item
  end

  private

  def create_order_item
    item_exist ? increase_quantity(item_exist) : save_item
  end

  def item_exist
    current_order.order_items.find_by(book_id: order_params[:book_id])
  end

  def increase_quantity(item_exist)
    item_exist.quantity += order_params[:quantity].to_i
    item_exist.save
  end

  def save_item
    return unless order_item_form.valid?
    current_order.order_items.create(book_id: order_item_form.book_id, quantity: order_item_form.quantity)
  end
end