class BookPresenter < ApplicationPresenter

  attr_reader :book

  def initialize(current_book)
    @book = current_book
  end
  
  MAX_DESCRIPTION_LENGTH = 250

  def description
    truncate(book.description, :length => MAX_DESCRIPTION_LENGTH)
  end

  def full_description
    book.description
  end

  def dimensions
    "H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}"
  end

  def author_name
    book.authors.map { |author| author.name }.join(', ')
  end
end
