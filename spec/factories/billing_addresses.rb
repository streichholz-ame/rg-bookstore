FactoryBot.define do
  factory :billing_address do
    association :addressable, factory: :user

    first_name { 'Olena' }
    last_name { 'Shevchenko' }
    address { 'Khreschatyk' }
    city { 'Kyiv' }
    zip { 0o1001 }
    country { 'Ukraine' }
    phone { '+3803333333' }
    type { 'BillingAddress' }
  end
end
