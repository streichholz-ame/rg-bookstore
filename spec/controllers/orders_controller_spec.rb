require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:address) { create(:billing_address) }
  let!(:order1) do
    create(:order, :with_item, :with_credit_card, :with_delivery, user_id: user.id, address_id: address.id,
                                                                  status: 'complete')
  end
  let!(:order2) do
    create(:order, :with_item, :with_credit_card, :with_delivery, user_id: user.id, address_id: address.id,
                                                                  status: 'in_delivery')
  end

  describe 'orders' do
    before do
      login_as(user)
      allow(subject).to receive(:current_user).and_return(user)
    end

    describe 'when #index' do
      before { get :index }
      it { is_expected.to respond_with 200 }
    end

    describe 'when #show' do
      before do
        get :show, params: { id: order1.id }
      end

      it { is_expected.to respond_with 200 }
    end
  end
end
