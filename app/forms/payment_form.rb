class PaymentForm
  include ActiveModel::Model
  include Virtus.model

  CARD_NUMBER_REGEX = /\A\d+\z/.freeze
  CARD_NAME_REGEX = /\A[a-z A-Z]+\z/.freeze
  CARD_EXPIRE_REGEX = %r{\b(0[1-9]|1[0-2])/([0-9]{4})\b}.freeze

  attribute :number, String
  attribute :name, String
  attribute :date, String
  attribute :cvv, String

  validates :number, :name, :date, :cvv, presence: true
  validates :number, format: { with: CARD_NUMBER_REGEX }, length: { minimum: 16, maximum: 16 }
  validates :name, format: { with: CARD_NAME_REGEX }
  validates :date, format: { with: CARD_EXPIRE_REGEX }
  validates :cvv, length: { minimum: 3, maximum: 4 }
end
