class CatalogController < ApplicationController

  def index
    @categories = Category.all
  end
  
end
