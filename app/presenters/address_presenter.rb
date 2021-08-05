class AddressPresenter
  attr_reader :current_user
  def initialize(current_user)
    @current_user = current_user
  end
  HAS_ERROR = '.has-error'.freeze

  def current_value(current_user, address_type, address_field)
    #address_type == 'BillingAddress' ? billing(current_user, address_field) : shipping(current_user, address_field)
  end
  
  def billing
    AddressForm.new
    #form = current_user.billing_address || AddressForm.new
    #form[address_field]
  end

  def shipping(current_user, address_field)
    form = current_user.shipping_address || AddressForm.new
    form[address_field]
  end

  def countries_for_select
    ISO3166::Country.countries.sort_by(&:name)
  end
end
