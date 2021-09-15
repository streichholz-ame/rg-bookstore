FactoryBot.define do
  factory :address do
    association :addressable, factory: :user

    first_name { 'Olena' }
    last_name { 'Shevchenko' }
    address { 'Khreschatyk' }
    city { 'Kyiv' }
    zip { 0o1001 }
    country { 'Ukraine' }
    phone { '+3803333333' }
    type { 'BillingAddress' }

    trait :with_type_shipping do
      after(:create) do |_address|
        type { 'ShippingAddress' }
      end
    end
  end
end
