class AddressDatabaseService
  attr_reader :params, :current_user, :form

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @billing = AddressForm.new(params[:billing_form])
    @shipping = AddressForm.new(params[:shipping_form])
  end

  def create_address
    new_address = Address.new(form.attributes.without(:user_id))
    new_address.save
  end

  def update_address(current_address)
    current_address.update(form.attributes.without[:user_id])
  end
end