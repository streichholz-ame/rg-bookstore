require 'rails_helper'

RSpec.describe AddressPresenter do
  let(:user) { create(:user) }
  let(:billing_address) { create(:billing_address, addressable: user) }
  let(:shipping_address) { create(:shipping_address, addressable: user) }
  let(:presenter) { described_class.new(user) }

  context 'when address dont exist' do
    it '#billing_form' do
      expect(presenter).to receive(:billing_form).and_return(AddressForm.new)
      presenter.billing_form
    end

    it '#shipping_form' do
      expect(presenter).to receive(:shipping_form).and_return(AddressForm.new)
      presenter.shipping_form
    end
  end

  context 'when address exist' do
    it '#billing_address' do
      presenter.fill_field(billing_address.type, billing_address[:name])
      expect(presenter.billing_address('name')).to eq(billing_address[:name])
    end

    it '#shipping_address' do
      presenter.fill_field(shipping_address.type, shipping_address[:name])
      expect(presenter.shipping_address('name')).to eq(shipping_address[:name])
    end
  end
end
