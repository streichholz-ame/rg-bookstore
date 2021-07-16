class SortingService

  attr_reader :books, :params

  SORTING_METHODS = {
    newest: 'id DESC',
    title_asc: 'name ASC',
    title_desc: 'name DESC',
    price_asc: 'price ASC',
    price_desc: 'price DESC'
  }

  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    @books_by_category = show_books_by_categories
    sort_books
  end

  def sort_books
    params[:sort] = :newest unless SORTING_METHODS.include?(params[:sort]&.to_sym)
    
    @books_by_category.order(SORTING_METHODS.key(params[:sort]))
  end

  def show_books_by_categories
    params[:id].nil? ? books : books.where(category_id: params[:id])
  end
end