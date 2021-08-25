class Book < ApplicationRecord
  validates :name, presence: true

  mount_uploader :image, ImageUploader

  belongs_to :category

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
