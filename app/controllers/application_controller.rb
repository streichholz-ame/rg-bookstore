class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :header_presenter, :current_or_guest_user
  helper_method :current_order
  attr_reader :guest_order

  GUEST_EMAIL_NUM = 99

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
      set_user_order if session[:guest_user_id]
      current_user.add_role :user
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

  def pundit_user
    current_or_guest_user
  end

  def current_order
    if current_user && current_user.orders.processing.present?
      current_user.orders.processing.last
    elsif session[:current_order_id]
      Order.find(session[:current_order_id])
    else
      Order.new(user_id: logged_in_or_guest)
    end
  end

  private

  def create_guest_user
    user = User.create(email: "guest_#{Time.now.to_i}#{rand(GUEST_EMAIL_NUM)}@example.com")
    user.add_role :guest_user
    user.save!(validate: false)
    session[:guest_user_id] = user.id
    user
  end

  def logged_in_or_guest
    current_user ? current_user.id : session[:guest_user_id]
  end

  def user_not_authorized
    flash[:alert] = I18n.t('flash.no_access')
    redirect_to(request.referer || root_path)
  end

  def set_user_order
    logging_in
    guest_user.destroy
    session[:guest_user_id] = nil
  end

  def logging_in
    @guest_order = Order.find_by(user_id: guest_user.id)
    if guest_order
      check_existing_order
    else
      current_order
    end
  end

  def new_order
    Order.create(user_id: current_user.id)
  end

  def find_order
    Order.processing.find_by(user_id: current_user.id)
  end

  def check_existing_order
    if current_user.orders.processing.empty?
      new_order.order_items.append(guest_order.order_items)
    else
      find_order.order_items.append(guest_order.order_items)
    end
  end
end
