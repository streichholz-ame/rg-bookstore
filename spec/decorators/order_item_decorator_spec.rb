require 'rails_helper'

RSpec.describe OrderItemDecorator do
  let(:user) { create(:user) }
  let(:order) { create(:order, :with_item, user_id: user.id) }
  let(:order_item) { order.order_items.first }
  let(:decorator) { order_item.decorate }

  describe 'order_item_price' do
    let(:price) { order_item.book.price * order_item.quantity }
    it 'return price' do
      expect(decorator.order_item_price).to eq(price)
    end
  end
end
