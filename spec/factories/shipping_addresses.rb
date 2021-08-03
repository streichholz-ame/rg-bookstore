FactoryBot.define do
  factory :shipping_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::Address.country }
    phone { FFaker::PhoneNumberUA.international_mobile_phone_number }
    addressable_type { :shipping_address }
  end
end
