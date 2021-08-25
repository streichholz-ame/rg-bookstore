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
    saved_order = Order.find_by(user_id: session[:session_id])
    if session[:current_order_id]
      Order.find(session[:current_order_id])
    elsif current_user && saved_order
      saved_order.update(user_id: current_user.id)
    elsif current_user && Order.find_by(user_id: current_user.id)
      Order.find_by(user_id: current_user.id)
    else
      Order.new(user_id: logged_in_or_guest)
    end
  end

  def logged_in_or_guest
    current_user ? current_user.id : session[:session_id]
  end

  include Pagy::Backend
end
