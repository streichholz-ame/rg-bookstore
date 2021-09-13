class ApplicationController < ActionController::Base
  include Pundit
  before_action :header_presenter, :current_or_guest_user
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

  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user
  end

  def logging_in
    guest_order = Order.find_by(user_id: guest_user.id)
    if guest_order
      Order.checkout_process.find_or_initialize_by(user_id: current_user.id).order_items.append(guest_order.order_items)
    else
      current_order
    end
  end

  def create_guest_user
    u = User.create(email: "guest_#{Time.now.to_i}#{rand(99)}@example.com")
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end

  def current_order
    if current_user && Order.checkout_process.find_by(user_id: current_user.id)
      Order.find_by(user_id: current_user.id)
    elsif session[:current_order_id]
      Order.find(session[:current_order_id])
    else
      Order.new(user_id: logged_in_or_guest)
    end
  end

  def logged_in_or_guest
    current_user ? current_user.id : session[:guest_user_id]
  end

  include Pagy::Backend
end
