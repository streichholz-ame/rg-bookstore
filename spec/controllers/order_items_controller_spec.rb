require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let(:order) { create(:order) }
  let(:order_params) { { book_id: book.id, quantity: 1 } }

  before do
    login_as(user)
    allow(subject).to receive(:current_order).and_return(order)
  end

  describe 'POST #create' do
    it 'created' do
      post :create, params: { order_item: order_params }
      expect(subject).to set_flash[:success]
    end
  end

  describe 'PUT #update' do
    let(:order_item) { order.order_items.first }
    it 'update' do
      allow(OrderItem).to receive(:find_by).and_return(order_item)
      put :update, params: { item_quantity: order_item.quantity, plus: true, id: order_item.id }
      expect(subject).to redirect_to carts_path
    end
  end

  describe 'DELETE #destroy' do
    let(:order_item) { order.order_items.first }
    it 'delete' do
      allow(OrderItem).to receive(:find_by).and_return(order_item)
      delete :destroy, params: { id: order_item.id }
      expect(subject).to set_flash[:success]
    end
  end
end
