class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true

  scope :processing, -> { where(status: 'complete') }
  scope :in_delivery, -> { where(status: 'in_delivery') }
  scope :delivered, -> { where(status: 'delivered') }
  scope :canceled, -> { where(status: 'canceled') }

  has_many :order_items, dependent: :destroy

  enum status: { cart: 0, log_in: 1, address: 2, shipping: 3, payment: 4, confirm: 5, complete: 6,
  in_delivery: 7, delivered: 8, canceled: 9 }
end
