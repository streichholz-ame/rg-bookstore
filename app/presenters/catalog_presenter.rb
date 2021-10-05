class CatalogPresenter < ApplicationPresenter
  NEW_BOOKS_COUNT = 3

  def categories
    Category.all
  end

  def carousel_newest_books
    subject.last(NEW_BOOKS_COUNT)
  end

  def author_name(book)
    book_authors(book).map { |author| author }.join(', ')
  end

  def book_authors(book)
    book.authors.map do |author|
      "#{author.first_name}" "#{author.last_name}"
    end
  end

  def books_by_category_count(category)
    subject.where(category_id: category).count
  end
end
