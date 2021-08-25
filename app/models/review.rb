class Review < ApplicationRecord
  enum status: { processing: 0, rejected: 1, published: 2 }

  belongs_to :user
  belongs_to :book

  def approve!
    update(status: 'published')
  end

  def reject!
    update(status: 'rejected')
  end
end
