class HomepageController < ApplicationController
  def index
    @catalog_presenter = CatalogPresenter.new(Book.all)
  end
end
