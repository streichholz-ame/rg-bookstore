class BooksController < ApplicationController

  def show
    @catalog_presenter = CatalogPresenter.new(params: params)
    @book_presenter = BookPresenter.new(params: params)
    @current_book = Book.find_by(id: params[:id])
  end

end
