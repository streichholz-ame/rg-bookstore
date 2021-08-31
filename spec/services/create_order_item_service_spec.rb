require 'rails_helper'

RSpec.describe CreateOrderItemService do
  let(:order) { create(:order) }
  let(:create_service) { described_class.new(order_params, params) }

  describe 'change cart' do
    let(:order_params) { { quantity: 1, book_id: order.order_items.last.book_id } }
    let(:params) { order_params  }

    describe 'increase quantity' do
      it 'increase' do
        expect { create_service.call(order) }.to change { order.order_items.last.quantity }.by(1)
      end
    end

    describe 'create new item' do
      let(:book) { create(:book) }
      let(:params) { order_params }
      let(:order_params) { { quantity: 1, book_id: book.id } }

      it 'create new item' do
        expect { create_service.call(order) }.to change { order.order_items.size }.by(1)
      end
    end
  end
end
