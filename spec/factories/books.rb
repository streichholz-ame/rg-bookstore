FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
    price { rand(12.99..99.99).round(2) }
    height { 9 }
    width { 6 }
    depth { 2 }
    material { 'Hardcover Book' }
    publication_year { rand(2000..2021) }

    category
  end
end
