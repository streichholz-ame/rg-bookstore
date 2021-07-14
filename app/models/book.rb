class Book < ApplicationRecord
  belongs_to :category

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, dependent: :destroy
end
