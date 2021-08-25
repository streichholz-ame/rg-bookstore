class OrderItemForm
  include ActiveModel::Model
  include Virtus.model

  attribute :book_id, Integer
  attribute :quantity, Integer

  validates :book_id, :quantity, presence: true
end
