FactoryBot.define do
  factory :delivery do
    name { 'delivery' }
    price { 5.0 }
    days_min { 1 }
    days_max { 3 }
  end
end
