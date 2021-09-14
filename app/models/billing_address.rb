class BillingAddress < Address
  NAMES_AND_CITY_VALIDATION = /\A[a-zA-Z]+\z/.freeze
  ZIP_VALIDATION = /\A\d+\z/.freeze
  PHONE_VALIDATION = /\A\+\d+\z/.freeze
  ADDRESS_VALIDATION = /\A[a-zA-Z ,-]+\z/.freeze
  ADDRESS_TYPES = %w[ShippingAddress BillingAddress].freeze

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :type, presence: true
  validates :address, :first_name, :last_name, :city, :country, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: NAMES_AND_CITY_VALIDATION }
  validates :type, inclusion: { in: ADDRESS_TYPES }
  validates :zip, length: { maximum: 10 }, format: { with: ZIP_VALIDATION }
  validates :address, format: { with: ADDRESS_VALIDATION }
  validates :phone, length: { maximum: 15 }, format: { with: PHONE_VALIDATION }
end
