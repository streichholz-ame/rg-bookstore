class CatalogController < ApplicationController
  before_action :filter_books

  def index
    @catalog_presenter = CatalogPresenter.new
    @sorted_books = SortingService.new(@filtered_books, params).call
    @pagy, @books = pagy(@sorted_books, items: 12)
  end

  private

  def filter_books
    @filtered_books = params[:id].nil? ? Book.all : Book.where(category_id: params[:id])
  end
end
