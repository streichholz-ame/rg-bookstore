require 'rails_helper'

RSpec.describe AddressPresenter do
  let(:user) { create(:user) }
  let(:billing_address) { create(:billing_address, addressable: user) }
  let(:presenter) { described_class.new(user)}

  context '#full_field' do

  end

  context 'when address dont exist' do
    it '#billing_form' do

    end

    it '#shipping_form' do

    end
  end

  context 'when address exist' do
    it '#billing_address' do

    end

    it '#shipping_address' do

    end
  end
  

end
