class CatalogPresenter < ApplicationPresenter
  NEW_BOOKS_COUNT = 3

  def categories
    Category.all
  end

  def best_sellers
    best_sold_books = books_sold.group_by(&:category_id).map { |_, v| v.first }.map(&:id)
    Book.find(best_sold_books)
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

  def books_sold
    Book.find_by_sql("SELECT b.id, b.category_id, SUM(oi.quantity) as book_count
    FROM order_items AS oi
    JOIN books AS b ON b.id = oi.book_id
    GROUP BY b.id, b.category_id
    ORDER BY SUM(oi.quantity) DESC")
  end
end
