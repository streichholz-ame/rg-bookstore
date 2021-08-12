class BookDecorator < ApplicationDecorator
  delegate_all

  MAX_DESCRIPTION_LENGTH = 250

  def description
    book.description[0...MAX_DESCRIPTION_LENGTH]
  end

  def full_description
    book.description
  end

  def dimensions
    I18n.t('book_page.dimentions_description', height: book.height, width: book.width, depth: book.depth)
  end

  def author_name
    book_authors.map {|author| author }.join(', ')
  end

  def book_authors
    book.authors.map do |author|
      "#{author.first_name}" "#{author.last_name}"
    end        
  end
end
