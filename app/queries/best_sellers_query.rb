class BestSellersQuery
  def run
    best_sold_books = books_sold.group_by(&:category_id).map { |_, v| v.first.id }
    Book.find(best_sold_books)
  end

  private

  def books_sold
    Book.find_by_sql("SELECT book.id, book.category_id, SUM(order_item.quantity) as book_count
    FROM order_items AS order_item
    JOIN books AS book ON book.id = order_item.book_id
    GROUP BY book.id, book.category_id
    ORDER BY book_count DESC")
  end

  def best_sellers
    # <<-SQL
    #   SELECT 
  end
end
