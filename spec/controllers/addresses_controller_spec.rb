require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:user_address) { create(:billing_address, addressable: user) }
  let(:not_valid_address) { create(:billing_address, addressable: user, first_name: '') }

  context 'POST #create' do
    before do
      login_as(user)
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'successfully' do
      post :create, params: { address_form: user_address.attributes }
      expect(subject).to set_flash[:success]
    end
  end
end
