module Showable
  def show_log_in
    return jump_to(next_step) if user_signed_in?
  end

  def show_address
    @presenter = AddressPresenter.new(current_user)
  end

  def cart_empty
    return if current_order.order_items.present?

    flash[:error] = I18n.t('cart.when_no_items')
  end

  def show_delivery
    cart_presenter
    @deliveries = present(Delivery.all)
    order_item
  end

  def show_payment
    cart_presenter
    @credit_card_presenter = CreditCardPresenter.new(current_order.credit_card)
    order_item
  end

  def show_confirm
    @orders = current_order.decorate
    order_item
    cart_presenter
  end

  def show_complete
    cart_presenter
    @orders = current_order.decorate
    order_item
    order_number
  end

  private

  def cart_presenter
    @cart_presenter = CartPresenter.new(current_order)
  end

  def order_item
    @order_items = OrderItemDecorator.decorate_collection(current_order.order_items)
  end

  def order_number
    order_number = (('A'..'Z').to_a).sample(2).join + ((0..9).to_a).sample(6).join
    current_order.update(number: order_number)
  end
end
