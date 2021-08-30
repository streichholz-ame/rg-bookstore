class CheckoutController < ApplicationController
  include Devise::Controllers::Helpers
  include Wicked::Wizard
  steps :log_in, :complete

  def show
    return redirect_to catalog_index_path if cart_empty?
    current_order.send("#{step}!")

    send("show_#{step}")
    render_wizard
  end

  private 

  def show_log_in
    return jump_to(next_step) if user_signed_in?
  end

  def cart_empty?
    return unless current_order.order_items.empty?
    flash[:error] = I18n.t('cart.when_no_items')
  end

  def show_complete
    order_number = (('A'..'Z').to_a).sample(2).join + ((0..9).to_a).sample(6).join
    current_order.update(number: order_number)
  end
end
