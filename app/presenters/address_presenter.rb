class AddressPresenter < ApplicationPresenter
  def fill_fields(type, field)
    return unless subject.addresses.exists?(type: type)

    case type
    when BillingAddress.name then billing_address(field)
    when ShippingAddress.name then shipping_address(field)
    end
  end

  def addresses
    AddressForm.new
  end

  def billing_form
    AddressForm.new
  end

  def shipping_form
    AddressForm.new
  end

  def billing_address(field)
    subject.billing_address[field]
  end

  def shipping_address(field)
    subject.shipping_address[field]
  end
end
