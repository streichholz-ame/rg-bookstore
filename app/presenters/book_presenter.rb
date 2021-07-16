class BookPresenter < ApplicationPresenter
  def categories
    Category.all
  end
end
