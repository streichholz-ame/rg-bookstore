class CheckoutController < ApplicationController
  include Devise::Controllers::Helpers
  include Wicked::Wizard
  include Showable
  include Updatable

  steps :log_in, :address, :delivery, :payment, :confirm, :complete

  def show
    authorize current_order unless step == :log_in
    return redirect_to catalog_index_path if cart_empty?

    send("show_#{step}")

    render_wizard
  end

  def update
    current_order.update(status: params[:id])

    send("update_#{step}")
    redirect_to next_wizard_path unless performed?
  end
end
