class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  belongs_to :order, optional: true
end
