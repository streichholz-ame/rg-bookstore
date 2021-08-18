class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :book, optional: true
end
