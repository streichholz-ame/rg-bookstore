class ApplicationController < ActionController::Base
  before_action :header_presenter
  helper_method :current_order

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def header_presenter
    @header_presenter = HeaderPresenter.new(current_order)
  end

  def new_session_path(_scope)
    new_user_session_path
  end

  def current_order
    if !session[:current_order_id].nil?
      Order.find(session[:current_order_id])
    else
      Order.new
    end
  end

  include Pagy::Backend
end
