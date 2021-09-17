require 'ffaker'

def generate_categories
  Category.new(id: 1, name: 'Mobile development').save!
  Category.new(id: 2, name: 'Photo').save!
  Category.new(id: 3, name: 'Web design').save!
  Category.new(id: 4, name: 'Web development').save!
end

def generate_book
  book = Book.new(
    category_id: rand(1..4),
    name: FFaker::Book.title,
    description: FFaker::Book.description,
    price: rand(12.99..99.99).round(2),
    height: 9,
    width: 6,
    depth: 2,
    material: 'Hardcover Book',
    publication_year: rand(2000..2021)
  )
  File.open("public/images/#{rand(1..12)}.jpg") do |image|
    book.image = image
  end
  book.save!
end

def generate_author
  author = Author.new(
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    description: FFaker::Lorem.sentence
  )
  author.save!
end

def generate_book_authors
  authors = Author.all
  books = Book.all
  authors_id = authors.map(&:id)
  books.each do |book|
    2.times do
      BookAuthor.create(book_id: book.id, author_id: authors_id[rand(authors_id.length)])
    end
  end
end

def generate_book_images
  Book.all.each do |book|
    3.times do
      image = Image.new(book_id: book.id)
      File.open("public/images/#{rand(1..12)}.jpg") do |f|
        image.image = f
      end
      image.save
    end
  end
end

def generate_coupon
  Coupon.create(number: '12345')
end

generate_categories
30.times { generate_book }
30.times { generate_author }
generate_book_authors
generate_book_images
generate_coupon
AdminUser.create!(email: 'admin@example.com', password: 'password',
                  password_confirmation: 'password')
