FactoryBot.define do
  factory :review do
    title { "MyString" }
    review_text { "MyString" }
    text { "MyString" }
    rating { 1 }
    user { "" }
    book { "" }
  end
end
