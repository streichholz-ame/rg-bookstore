class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true

  has_one :address, dependent: nil
  accepts_nested_attributes_for :address, reject_if: proc { |attributes| attributes.any.blank? }

  scope :processing, -> { where(status: %w[cart address delivery payment confirm]) }
  scope :complete, -> { where(status: %w[complete]) }
  scope :in_delivery, -> { where(status: %w[in_delivery]) }
  scope :delivered, -> { where(status: %w[delivered]) }
  scope :canceled, -> { where(status: %w[canceled]) }

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
    update(status: %w[canceled])
  end

  def set_in_delivery!
    update(status: %w[in_delivery])
  end

  def deliver!
    update(status: %w[delivered])
  end
end
