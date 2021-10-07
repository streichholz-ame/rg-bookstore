class CatalogController < ApplicationController
  before_action :filter_books

  def index
    @catalog_presenter = CatalogPresenter.new(Book.all)
    @sorted_books = SortingService.new(@filtered_books, params).call
    @pagy, @books = pagy(@sorted_books, items: 12)
  end

  private

  def filter_books
    @filtered_books = params[:id] ? Book.where(category_id: params[:id]) : Book.all
  end
end
