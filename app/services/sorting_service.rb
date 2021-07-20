class SortingService
  attr_reader :books, :params

  SORTING_METHODS = {
    newest: 'id DESC',
    title_asc: 'name ASC',
    title_desc: 'name DESC',
    price_asc: 'price ASC',
    price_desc: 'price DESC'
  }.freeze

  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    sort_books
  end

  private

  def sort_books
    check_sort_params
    books.order(SORTING_METHODS[params[:sort].to_sym])
  end

  def check_sort_params
    return if SORTING_METHODS.include?(params[:sort]&.to_sym)

    params[:sort] = :newest
  end
end
