require 'rails_helper'

RSpec.describe DeleteOrderItemService do
  let(:order) { create(:order) }
  let(:order_item) { order.order_items.first }
  let(:params) { { id: order_item.id } }
  let(:delete_service) { described_class.new(order, params) }

  describe 'delete item' do
    it 'successfully' do
      expect { delete_service.call }.to change { order.order_items.count }.by(-1)
    end
  end
end
