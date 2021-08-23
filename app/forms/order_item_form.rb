class OrderItemForm
  include ActiveModel::Model
  include Virtus.model

  attribute :user_id, Integer
  attribute :book_id, Integer
  attribute :quantity, Integer

  validates :book_id, :quantity, presence: true
end
