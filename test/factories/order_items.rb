FactoryBot.define do
  factory :order_item do
    order { nil }
    book { nil }
    quantity { 1 }
  end
end
