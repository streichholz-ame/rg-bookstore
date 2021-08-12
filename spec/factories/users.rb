FactoryBot.define do
  factory :user do
    password { FFaker::Internet.password }
    email { FFaker::Internet.email }
    confirmed_at { Time.current }
  end
end
