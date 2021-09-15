FactoryBot.define do
  factory :credit_card do
    number { '1' * 16 }
    name { 'Name' }
    date { '10/2020' }
    cvv { '123' }
  end
end
