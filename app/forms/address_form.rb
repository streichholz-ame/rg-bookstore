class AddressForm

  include ActiveModel::Model
  include Virtus

  NAMES_AND_CITY_VALIDATION = /\A[a-zA-Z]+\z/.freeze
  ZIP_VALIDATION = /\A\d+\z/.freeze
  PHONE_VALIDATION = /\A\+\d+\z/.freeze
  ADDRESS_VALIDATION = /\A[a-zA-Z ,-]+\z/.freeze
  ADDRESS_TYPES = %w[ShippingAddress BillingAddress]

  attribute :addressable_id, Integer

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country, String
  attribute :phone, String
  attribute :type, String

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :type, presence: true
  validates :address, :first_name, :last_name, :city, :country, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: NAMES_AND_CITY_VALIDATION }
  validates :type, inclusion: { in: ADDRESS_TYPES }
  validates :zip, length: { maximum: 10 }, format: { with: ZIP_VALIDATION }
  validates :address, format: { with: ADDRESS_VALIDATION }
  validates :phone, length: { maximum: 15 }, format: { with: PHONE_VALIDATION }

  def params
    { first_name: first_name, last_name: last_name, street: street,
      country: country, city: city, zip: zip, phone: phone }
  end

  def save_address(params, current_user)
    #params[:addressable] = current_user
    current_user.addresses.find_or_initialize_by(type: params[:type]).update(params)
#    return unless address_form.valid?

#    current_address.update(address_form.attributes.without(:addressable_id))
  end
end
