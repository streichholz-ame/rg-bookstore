FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
    image { File.open('spec/fixtures/images/default.jpg') }
    price { rand(12.99..99.99).round(2) }
    height { 9 }
    width { 6 }
    depth { 2 }
    material { 'Hardcover Book' }
    publication_year { rand(2000..2021) }

    category
  end

  trait :with_author do
    after(:create) do |book|
      create(:author, books: [book])
    end
  end
end
