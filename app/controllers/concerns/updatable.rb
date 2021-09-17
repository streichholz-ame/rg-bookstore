module Updatable
  def update_address
    @presenter = AddressPresenter.new(current_user)
    address = Addresses::Edit.new(address_params[:address_form], current_user).call
    render_wizard unless address
    current_order.update(address_id: order_address.id)
  end

  def update_delivery
    current_order.update(delivery_params)
  end

  def update_payment
    credit_card = PaymentForm.new(card_params)
    create_card if credit_card.valid?
  end

  def update_confirm
    current_order.save
  end

  def update_complete
    redirect_to catalog_index_path

    clear_order_session
  end

  def clear_order_session
    session.delete(:current_order_id)
    cookies.delete(:current_order_id)
  end

  def order_address
    @order = Order.find_by(id: params[:id])

    return current_user.billing_address unless current_user.shipping_address

    current_user.shipping_address
  end

  def delivery_params
    params.require(:order).permit(:delivery_id)
  end

  def create_card
    card = CreditCard.create(card_params)
    current_order.update(credit_card_id: card.id)
  end

  def address_params
    params.require(:order).permit(
      address_form: %i[addressable_id addressable_type type first_name last_name address city zip country phone]
    )
  end

  def card_params
    params.require(:payment_form).permit(:number, :name, :date, :cvv)
  end

  def status_params
    params.permit(:id)
  end
end
