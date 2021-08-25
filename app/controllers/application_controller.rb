class ApplicationController < ActionController::Base
  before_action :header_presenter

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def header_presenter
    @header_presenter = HeaderPresenter.new
  end
  include Pagy::Backend
end
