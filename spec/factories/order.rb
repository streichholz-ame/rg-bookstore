FactoryBot.define do
  factory :order do
    user
    address
    trait :with_item do
      after(:create) do |order|
        2.times { create(:order_item, order_id: order.id) }
      end
    end

    trait :with_credit_card do
      credit_card { create(:credit_card) }
    end

    trait :with_delivery do
      delivery { create(:delivery) }
    end

    trait :with_coupon do
      coupon { create(:coupon) }
    end
  end
end
