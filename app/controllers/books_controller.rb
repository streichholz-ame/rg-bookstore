class BooksController < ApplicationController
  def show
    @catalog_presenter = CatalogPresenter.new(params: params)
    @current_book = Book.find_by(id: params[:id])
    @book_presenter = BookPresenter.new(@current_book)
  end
end
