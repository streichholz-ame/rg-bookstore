class BooksController < ApplicationController
  def show
    @catalog_presenter = CatalogPresenter.new(Book.all)
    @current_book = Book.find_by(id: params[:id])
    @review = ReviewPresenter.new(@current_book)
    @book_decorator = @current_book.decorate
    @book = present(@current_book)
  end
end
