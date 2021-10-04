require 'rails_helper'

RSpec.describe UpdateOrderItemService do
  let(:order) { create(:order) }
  let(:params) { { id: order.order_items.first.id, plus: true, item_quantity: 2 } }
  let(:update_service) { described_class.new(params) }

  describe '#call' do
    let(:new_quantity) { 3 }
    it 'change item count' do
      expect { update_service.call }.to change {
                                          order.order_items.first.quantity
                                        }.from(params[:item_quantity]).to(new_quantity)
    end
  end
end
