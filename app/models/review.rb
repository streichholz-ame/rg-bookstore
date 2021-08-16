class Review < ApplicationRecord
  enum status: [:processing, :rejected, :published]

  belongs_to :user
  belongs_to :book
end
