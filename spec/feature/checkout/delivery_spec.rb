require 'rails_helper'

describe 'Delivery Page', type: :feature do
  let!(:user) { create(:user) }
  let(:billing_address) { create(:billing_address, addressable: user) }
  let!(:order) { create(:order, :with_item, user_id: user.id) }
  let!(:delivery) { create(:delivery) }

  before { login_as(user) }

  context 'choose delivery' do
    before do
      visit checkout_path(:delivery)
    end
    it 'show delivery types' do
      find('label', class: 'radio-label').click
      click_on I18n.t('checkout.continue_btn')
      expect(page).to have_current_path checkout_path(:payment)
    end
  end
end
