require 'ffaker'

def generate_categories
  Category.new(id: 1, name: 'Mobile development').save!
  Category.new(id: 2, name: 'Photo').save!
  Category.new(id: 3, name: 'Web design').save!
end

def generate_book
  book = Book.new(
    category_id: rand(1..3),
    name: FFaker::Book.title,
    description: FFaker::Book.description,
    price: rand(12.99..99.99).round(2),
    height: 9,
    width: 6, 
    depth: 2,
    material: 'Hardcover Book'
  )
  File.open("public/images/#{rand(1..16)}.jpg") do |photo|
    book.photo = photo
  end
  book.save!
end

def generate_author
  author = Author.new(name: FFaker::Book.author)
  author.save!
end


generate_categories
20.times { generate_book}
20.times { generate_author }
