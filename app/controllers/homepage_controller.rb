class HomepageController < ApplicationController
  def index
    @catalog_presenter = CatalogPresenter.new(Book.all)
    @best_sellers = BestSellersQuery.new.run
  end
end
