def AddressService < AddressDatabaseService
  def call
    @form = params[:"#{type}"_form]
    return false unless @form.valid?
    
    create_or_update_address
  end

  def create_or_update_address
    current_address = current_user.addresses.find_by(type: params[:type])
    current_address ? update_address(current_address) : create_address
  end

  def show_addresses
    AddressPresenter.new
  end
end