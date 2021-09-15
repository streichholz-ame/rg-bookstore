class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(number: params[:number])
    coupon ? current_order.update(coupon: coupon) : flash[:error] = t('cart.coupon_error')
    redirect_to carts_path
  end
end
