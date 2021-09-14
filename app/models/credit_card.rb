class CreditCard < ApplicationRecord
  has_one :order, dependent: :nullify
end
