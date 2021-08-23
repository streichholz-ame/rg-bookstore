class HeaderPresenter
  attr_reader :current_order

  def initialize(current_order)
    @current_order = current_order
  end
  def categories
    Category.all
  end

  def cart_count
    current_order.order_items.map { |item| item[:quantity] }.sum
  end
end
