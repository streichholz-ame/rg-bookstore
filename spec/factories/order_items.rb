FactoryBot.define do
  factory :order_item do
    quantity { 2 }

    book
  end
end
