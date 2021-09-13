FactoryBot.define do
  factory :order do
    user
    delivery

    trait :with_item do
      after(:create) do |order|
        2.times { create(:order_item, order_id: order.id) }
      end
    end
  end
end
