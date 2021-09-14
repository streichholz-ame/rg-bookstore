FactoryBot.define do
  factory :address do
    association :addressable, factory: :user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
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
