class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
end
