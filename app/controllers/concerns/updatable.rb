module Updatable
  def update_address
    @addresses_form = Addresses::Edit.new(address_params[:billing_form], current_user).call
    unless address_params[:shipping_form].value?('')
      @addresses_form = Addresses::Edit.new(address_params[:shipping_form],
                                            current_user).call
    end
    current_order.update(address_id: order_address.id)
    render_wizard unless @addresses_form
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
    clear_order_session
    redirect_to catalog_index_path
  end

  def clear_order_session
    return unless current_order&.complete?

    cookies.delete(:current_order_id)
    session.delete(:current_order_id)
  end

  def delivery_params
    params.require(:order).permit(:delivery_id)
  end

  def create_card
    card = CreditCard.create(card_params)
    current_order.update(credit_card_id: card.id)
  end

  def address_params
    params.require(:address_form).permit(
      shipping_form:
      %i[addressable_id addressable_type type first_name last_name address
         city zip country phone],
      billing_form: %i[addressable_id addressable_type type first_name last_name address
                       city zip country phone]
    )
  end

  def order_address
    if current_user.shipping_address.nil?
      current_user.billing_address
    else
      current_user.shipping_address
    end
  end

  def card_params
    params.require(:payment_form).permit(:number, :name, :date, :cvv)
  end
end
