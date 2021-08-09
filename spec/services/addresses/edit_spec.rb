require 'rails_helper'

RSpec.describe Addresses::Edit do
  let(:edit_address) { described_class.new(params, user) }
  let(:user) { create(:user) }
  let(:billing_address) { create(:billing_address, addressable: user) }

  context 'with wrong type' do
    let(:params) { create(:billing_address, addressable: user, type: 'type') }
    it 'fails' do
      expect(edit_address).to receive(:call).and_return(nil)
      edit_address.call
    end
  end

  context 'with correct params' do
    let(:params) { create(:billing_address, addressable: user) }
    
    it 'save address' do 
      expect{ edit_address.call }.to change { user.billing_address }.to(billing_address)
    end
  end
end
