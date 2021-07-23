class CatalogDecorator < ApplicationDecorator
  NEW_BOOKS_COUNT = 3
  BEST_SELLERS_COUNT = 4

  delegate_all

  def best_sellers
    books.last(BEST_SELLERS_COUNT)
  end

  def carousel_newest_books
    books.last(NEW_BOOKS_COUNT)
  end

  def author_name(book)
    book.authors.map(&:name).join(', ')
  end

  delegate :count, to: :books, prefix: true

  def books_by_category_count(category)
    books.where(category_id: category).count
  end

end
