class BooksController < ApplicationController
  def show
    @catalog_presenter = CatalogPresenter.new
    @current_book = Book.find_by(id: params[:id])
    @book_decorator = @current_book.decorate
    @book_presenter = BookPresenter.new(@current_book)
  end
end
