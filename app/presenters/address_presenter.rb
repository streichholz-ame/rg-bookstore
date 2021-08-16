class AddressPresenter
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def fill_fields(type, field)
    return unless current_user.addresses.exists?(type: type)

    case type
    when BillingAddress.name then billing_address(field)
    when ShippingAddress.name then shipping_address(field)
    end
  end

  def billing_form
    AddressForm.new
  end

  def shipping_form
    AddressForm.new
  end

  def billing_address(field)
    current_user.billing_address[field]
  end

  def shipping_address(field)
    current_user.shipping_address[field]
  end
end
