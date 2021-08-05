require 'rails_helper'

RSpec.describe AddressService do
  let(:user) { create(:user) }
  let(:address) { create(:billing_address, addressable: user) }
  let(:other_address) {create(:billing_address, addressable: user)}
  let(:valid_create_params) { {params: address, addressable: user} }
  let(:valid_update_params) { { params: other_address, addressable: user } }

  context 'when address exist' do
    let(:address_service) { described_class.new(valid_update_params, user) }
    
    it 'update address' do 
      user.addresses << address
      expect{ address_service.call }.to change{user.billing_address}.from(address).to(other_address)
    end
  end

  context 'when address not exists' do
    let(:address_service) { described_class.new(valid_create_params, user) }

    it 'create address' do
      expect{ address_service.call }.to change{user.addresses.count}.from(0).to(1)
    end
  end

end