FactoryBot.define do
  factory :shipping_address do
    association :addressable, factory: :user

    first_name { 'Olena' }
    last_name { 'Shevchenko' }
    address { 'Khreschatyk' }
    city { 'Kyiv' }
    zip { 0o01001 }
    country { 'Ukraine' }
    phone { '+3803333333' }
    type { 'ShippingAddress' }
  end
end
