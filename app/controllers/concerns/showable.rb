module Showable
  def show_log_in
    return jump_to(next_step) if user_signed_in?
  end

  def show_address
    @addresses_form = AddressForm.new
    @presenter = AddressPresenter.new(current_user)
    @order_presenter = OrderPresenter.new(current_user)
  end

  def cart_empty?
    return unless current_order.order_items.empty?

    flash[:error] = I18n.t('cart.when_no_items')
  end

  def show_delivery
    @cart_presenter = CartPresenter.new(current_order)

    @deliveries = present(Delivery.all)
  end

  def show_payment
    @cart_presenter = CartPresenter.new(current_order)
    @credit_card_presenter = CreditCardPresenter.new(current_order.credit_card)
  end

  def show_confirm
    @order = present(current_order)
    @order_items = current_order.order_items
    @cart_presenter = CartPresenter.new(current_order)
  end

  def show_complete
    @order_items = current_order.order_items
    @cart_presenter = CartPresenter.new(current_order)
    @order = present(current_order)

    order_number = (('A'..'Z').to_a).sample(2).join + ((0..9).to_a).sample(6).join
    current_order.update(number: order_number)
  end
end
