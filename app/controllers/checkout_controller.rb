class CheckoutController < ApplicationController
  include Devise::Controllers::Helpers
  include Wicked::Wizard
  include Showable
  include Updatable

  steps :log_in, :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to catalog_index_path if cart_empty?

    send("show_#{step}")
    current_order.update(status: params[:id])

    render_wizard
  end

  def update
    send("update_#{step}")
    redirect_to next_wizard_path unless performed?
  end
end
