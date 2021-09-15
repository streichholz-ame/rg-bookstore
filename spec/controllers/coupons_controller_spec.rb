require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let!(:order) { create(:order, :with_item) }
  let!(:coupon) { create(:coupon) }

  describe 'PUT #update' do
    it 'update order' do
      put :update, params: { id: order.id, number: coupon.number }
      expect(subject).not_to set_flash[:error]
    end
  end
end
