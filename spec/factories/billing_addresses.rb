FactoryBot.define do
  factory :billing_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { 'Khreschatyk' }
    city { 'Kyiv' }
    zip { 0o001001 }
    country { 'Ukraine' }
    phone { '+3803333333' }
    addressable { 'user' }
    type { 'BillingAddress' }
  end
end
