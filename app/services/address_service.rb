class AddressService
  attr_reader :params, :current_user, :address_form

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @address_form = AddressForm.new(params)
  end

  def call
    create_or_update_address
  end

  private

  def create_or_update_address
    current_address = current_user.addresses.find_or_initialize_by(type: address_type).update(params)
    current_address ? update_address(current_address) : create_address
  end

  def create_address
    params[:addressable] = current_user
    new_address = Address.new(params)
    return unless address_form.valid?

    new_address.save
  end

  def update_address(current_address)
    params[:addressable] = current_user
    return unless address_form.valid?

    current_address.update(address_form.attributes.without(:addressable_id))
  end

  def address_type
    params[:type]
  end
end