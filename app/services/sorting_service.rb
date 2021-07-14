class SortingService

  attr_reader :books, :params

  SORTING_METHODS = {
    :newest => 'id DESC',
    :title_asc => 'name ASC',
    :title_desc => 'name DESC',
    :price_asc => 'price ASC',
    :price_desc => 'price DESC'
  }

  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    @books_by_category = show_books_by_categories
    sort_books(by)
  end

  def sort_books(by)
    @books_by_category.order(SORTING_METHODS.values_at(by))
  end

  def show_books_by_categories
    category = Book.where(category_id: params[:category_id])
    category.presence || books
  end
end