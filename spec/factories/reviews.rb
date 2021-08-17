FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.word }
    review_text { FFaker::Lorem.sentence }
    rating { rand(1..5) }

    user { association :user }
    book { association :book }

    status { 'processing' }
  end
end
