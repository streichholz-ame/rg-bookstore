FactoryBot.define do
  factory :shipping_address do
    association :addressable, factory: :user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { 'Khreschatyk' }
    city { 'Kyiv' }
    zip { 0o01001 }
    country { 'Ukraine' }
    phone { '+3803333333' }
    type { 'ShippingAddress' }
  end
end
