class ReviewForm
  include ActiveModel::Model
  include Virtus.model

  REVIEW_REGEX = /\A[a-zA-Z 0-9!#$%&'*+-/=?^_`{|}]+\z/

  attribute :title, String
  attribute :review_text, String
  attribute :rating, Integer
  attribute :current_book, Integer
  attribute :current_user, Integer

  validates :title, :review_text, :rating, presence: true
  validates :title, length: { max: 80 }, format: { with: REVIEW_REGEX }
  validates :review_text, length: { max: 500 }, format: { with: REVIEW_REGEX }
end