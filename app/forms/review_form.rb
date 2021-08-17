class ReviewForm
  include ActiveModel::Model
  include Virtus.model

  REVIEW_REGEX = %r{\A[a-zA-Z\d\s]+[-!#$%&'*+/=?^_`{|}~.,]?[a-zA-Z\d\s]*\z}.freeze

  attribute :title, String
  attribute :review_text, String
  attribute :rating, Integer
  attribute :book_id, Integer
  attribute :user_id, Integer

  validates :title, :review_text, :rating, presence: true
  validates :title, length: { maximum: 80 }, format: { with: REVIEW_REGEX }
  validates :review_text, length: { maximum: 500 }, format: { with: REVIEW_REGEX }
end
