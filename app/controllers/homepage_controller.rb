class HomepageController < ApplicationController
  def index
    @catalog_presenter = CatalogPresenter.new
  end
end
