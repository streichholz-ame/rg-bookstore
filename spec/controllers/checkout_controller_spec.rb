require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  include Showable
  include Updatable

  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  describe '#show' do
    let!(:order1) { create(:order, user_id: session[:guest_user_id]) }
    it 'log_in' do
      get :show, params: { id: :log_in }
      expect(subject).to respond_with 302
    end
  end

  describe '#update' do
  end
end
