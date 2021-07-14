class BooksController < ApplicationController

  def index
  end

  def show
    @categories = Category.all
    @current_book = Book.find_by(id: params[:id])
  end

end
