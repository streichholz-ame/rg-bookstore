class CatalogController < ApplicationController
  
  def index
    @catalog_presenter = CatalogPresenter.new(params: params)
    @sorted_books = SortingService.new(Book.all, params).call
    @pagy, @books = pagy(@sorted_books, items: 12)
  end

end
