class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true

  has_one :address, dependent: nil
  accepts_nested_attributes_for :address, reject_if: proc { |attributes| attributes.any.blank? }

  enum status: { cart: 0, address: 1, delivery: 2, payment: 3, confirm: 4, complete: 5,
                 in_delivery: 6, delivered: 7, canceled: 8 }

  scope :processing, -> { where(status: [0, 1, 2, 3, 4]) }
  scope :complete, -> { where(status: 5) }
  scope :in_delivery, -> { where(status: 6) }
  scope :delivered, -> { where(status: 7) }
  scope :canceled, -> { where(status: 8) }

  has_many :order_items, dependent: :destroy

  aasm(:status) do
    state :cart
    state :address
    state :delivery
    state :payment
    state :confirm
    state :complete
    state :in_delivery
    state :delivered
    state :canceled

    event :address do
      transitions from: :cart, to: :address
    end

    event :delivery_type do
      transitions from: :address, to: :delivery
    end

    event :payment do
      transitions from: :delivery, to: :payment
    end

    event :confirm do
      transitions from: :payment, to: :confirm
    end

    event :complete do
      transitions from: :confirm, to: :complete
    end

    event :in_delivery do
      transitions from: :complete, to: :in_delivery
    end

    event :delivered do
      transitions from: :in_delivery, to: :delivered
    end

    event :canceled do
      transitions from: %i[complete in_delivery delivered], to: :canceled
    end
  end

  def cancel!
    update(status: :canceled)
  end

  def set_in_delivery!
    update(status: :in_delivery)
  end

  def deliver!
    update(status: :delivered)
  end
end
