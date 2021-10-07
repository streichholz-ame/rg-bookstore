require 'rails_helper'
describe 'Payment Page', type: :feature do
  let!(:user) { create(:user) }
  let(:billing_address) { create(:billing_address, addressable: user) }
  let(:delivery) { create(:delivery) }
  let!(:order) do
    create(:order, :with_item, user_id: user.id, address_id: billing_address.id, delivery_id: delivery.id,
                               status: 'delivery')
  end
  let(:credit_card) { create(:credit_card) }
  let(:empty_field_message) { "can't be blank" }
  let(:wrong_input_message) { 'is invalid' }
  let(:too_long_input_message) { 'is too long' }
  let(:too_short_input_message) { 'is too short' }
  before { login_as(user) }

  context 'create card' do
    before do
      visit checkout_path(:payment)
    end
    it 'fill all fields' do
      within('#new_payment_form') do
        fill_in 'payment_form_number', with: credit_card.number
        fill_in 'payment_form_name', with: credit_card.name
        fill_in 'payment_form_date', with: credit_card.date
        fill_in 'payment_form_cvv', with: credit_card.cvv
        click_on I18n.t('checkout.continue_btn')
        expect(page).to have_current_path checkout_path(:confirm)
      end
    end
    it 'with empty field' do
      fill_in 'payment_form_number', with: ''
      click_on I18n.t('checkout.continue_btn')
      expect(page).to have_content empty_field_message
    end

    it 'with invalid field' do
      fill_in 'payment_form_number', with: billing_address.first_name
      click_on I18n.t('checkout.continue_btn')
      expect(page).to have_content wrong_input_message
    end

    it 'with invalid field' do
      fill_in 'payment_form_number', with: '1'
      click_on I18n.t('checkout.continue_btn')
      expect(page).to have_content too_short_input_message
    end

    it 'with invalid field' do
      fill_in 'payment_form_number', with: (credit_card.number * 2)
      click_on I18n.t('checkout.continue_btn')
      expect(page).to have_content too_long_input_message
    end
  end
end
