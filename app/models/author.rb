class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, dependent: :destroy
end
