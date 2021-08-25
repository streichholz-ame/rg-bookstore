module Addresses
  class Edit
    def initialize(params, user)
      @params = params
      @user = user
      @address_form = AddressForm.new
      @type = params[:type]
    end

    BILLING_ADDRESS = 'BillingAddress'.freeze
    SHIPPING_ADDRESS = 'ShippingAddress'.freeze
    ALLOWED_TYPES = [BILLING_ADDRESS, SHIPPING_ADDRESS].freeze

    def call
      return unless ALLOWED_TYPES.include?(@type)

      @address_form.save_address(@params, @user)
    end
  end
end
