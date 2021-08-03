class Address < ApplicationRecord
  belongs_to :resource, polymorphic: true

  has_many :billing_addresses, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy
end
