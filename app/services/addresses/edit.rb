class Addresses::Edit
  def initialize(params, user)
    @params = params
    @user = user
    @address_form = AddressForm.new
    @type = params[:type]
  end

  BILLING_ADDRESS = 'BillingAddress'
  SHIPPING_ADDRESS = 'ShippingAddress'
  ALLOWED_TYPES = [BILLING_ADDRESS, SHIPPING_ADDRESS].freeze

  def call
    return unless ALLOWED_TYPES.include?(@type)
    binding.pry

    @address_form.save_address(@params, @user)
  end
end