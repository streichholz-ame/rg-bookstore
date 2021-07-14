class CatalogController < ApplicationController

  def index
    @categories = Category.all
    @sorted_books = SortingService.new(Book.all, params).call
    @pagy, @books = pagy(@sorted_books, items: 12)
  end
  
end
