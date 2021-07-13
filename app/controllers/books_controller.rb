class BooksController < ApplicationController
  
  include Pagy::Backend

  def all_books
    @books = Book.all
  end
end
