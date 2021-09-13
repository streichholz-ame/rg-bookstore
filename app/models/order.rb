class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  has_one :address

  scope :checkout_process, -> { where(status: %w[cart address delivery payment confirm]) }
  scope :processing, -> { where(status: 'complete') }
  scope :in_delivery, -> { where(status: 'in_delivery') }
  scope :delivered, -> { where(status: 'delivered') }
  scope :canceled, -> { where(status: 'canceled') }

  has_many :order_items, dependent: :destroy

  aasm(:status) do
    state :cart
    state :address_type
    state :delivery_type
    state :payment
    state :confirm
    state :complete
    state :in_delivery
    state :delivered
    state :canceled

    event :address_type do
      transitions from: :cart, to: :address_type
    end

    event :delivery_type do
      transitions from: :address_type, to: :delivery_type
    end

    event :payment do
      transitions from: :delivery_type, to: :payment
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
end
