class CatalogPresenter < ApplicationPresenter

    NEW_BOOKS_COUNT = 3
    BEST_SELLERS_COUNT = 4

    def books
      Book.all
    end

    def categories
      Category.all
    end

    def carousel_newest_books
      books.last(NEW_BOOKS_COUNT)
    end
end
