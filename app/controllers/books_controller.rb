class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @categories = Category.all
  end

end
