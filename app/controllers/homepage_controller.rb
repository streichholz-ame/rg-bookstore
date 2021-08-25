class HomepageController < ApplicationController
  def index
    @catalog_presenter = CatalogPresenter.new(params: params)
  end
end
