require 'rails_helper'

RSpec.describe OrdersPresenter do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user_id: user.id) }
  let(:presenter) { described_class.new(user) }

  describe '#users_orders' do
    it 'return user orders' do
      expect(presenter.users_orders.size).to eq(1)
    end
  end

  describe '#order_status' do
    let(:order_complete) { create(:order, user_id: user.id, status: 'complete') }
    let(:order_in_delivery) { create(:order, user_id: user.id, status: 'in_delivery') }
    let(:order_delivered) { create(:order, user_id: user.id, status: 'delivered') }
    let(:order_canceled) { create(:order, user_id: user.id, status: 'canceled') }

    it "return 'processing checkout'" do
      expect(presenter.order_status(order)).to eq('Processing Checkout')
    end

    it "return 'processing'" do
      expect(presenter.order_status(order_complete)).to eq('Processing')
    end

    it "return 'in delivery'" do
      expect(presenter.order_status(order_in_delivery)).to eq('In Delivery')
    end

    it "return 'delivered'" do
      expect(presenter.order_status(order_delivered)).to eq('Delivered')
    end

    it "return 'canceled'" do
      expect(presenter.order_status(order_canceled)).to eq('Canceled')
    end
  end
end
