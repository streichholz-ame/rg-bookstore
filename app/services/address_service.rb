def AddressService
  def call
    @form = params[:shipping_form] ? @shipping : @billing
    false unless @form.valid?

    create_or_update_address
  end

  def create_or_update_address
    current_address = current_user.addresses.find_by(address_type: params[:address_type])
    current_address ? update_address(current_address) : create_address
  end
end