FactoryBot.define do
  factory :billing_address do
    association :addressable, factory: :user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { 'Khreschatyk' }
    city { 'Kyiv' }
    zip { 0o1001 }
    country { 'Ukraine' }
    phone { '+3803333333' }
    type { 'BillingAddress' }
  end
end
