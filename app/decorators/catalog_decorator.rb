class CatalogDecorator < ApplicationDecorator
  delegate_all

  NEW_BOOKS_COUNT = 3
  BEST_SELLERS_COUNT = 4

  def carousel_newest_books
    books.last(NEW_BOOKS_COUNT)
  end

  def author_name(book)
    book_authors(book).map { |str| "\"#{str}\"" }.join(',')
  end

  def book_authors(book)
    book.authors.map do |author|
      "#{author.first_name}" "#{author.last_name}"
    end
  end

  delegate :count, to: :books, prefix: true

  def books_by_category_count(category)
    books.where(category_id: category).count
  end
end
